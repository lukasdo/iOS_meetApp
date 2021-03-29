//
//  RegisterController.swift
//  LoginForm
//
//  Created by Lukas on 01.03.20.
//  Copyright © 2020 Lukas. All rights reserved.
//

import SwiftUI
import UIKit

public struct User: Codable {

    let first: String
    let last: String?
    let mail: String?

    enum CodingKeys: String, CodingKey {
        case first
        case last
        case mail
    }

}

struct RegisterUIController: UIViewControllerRepresentable {

    @Binding var username: String
    @Binding var password: String
    @Binding var name: String
    @Binding var calledFunc: Bool

    typealias UIViewControllerType = RegisterController
    
    
       class Coordinator {
           var previousClickID: Bool? = false
       }
       
       func makeCoordinator() -> Coordinator {
           return Coordinator()
       }

    func makeUIViewController(context: Context) -> RegisterController {
        let controller = RegisterController()
        return controller
    }

    func updateUIViewController(_ uiViewController: RegisterController, context: Context) {
        print("UpdateViewContrl")
        if calledFunc {
            uiViewController.onSignUp(email: username, password: password, name: name)
            calledFunc = false
        }
     
    }

}


class RegisterController: UIViewController {
    
        override func viewDidLoad() {
            super.viewDidLoad()
            print("ViewDidLoad")
                   
        }
        
        
     func onSignUp(email: String, password: String, name: String) {
        let db = FirebaseDB()
        let signUpManager = FirebaseAuthManager()
        
    
                print("Email: " + email + " PW: " + password)
            signUpManager.createUser(email: email, password: password) {[weak self] (success,user) in
                guard let self = self
                    else { return }
                var message: String = ""
                let uid = user?.uid
       
                if (success) {
                 
                    message = "User was sucessfully created."
                    let user = User(first: name, last: name, mail: email)
//                    TODO:: Name wegspeichern
//                    success.
                    db.addUser(values: user, key: uid!)
                    
                } else {
                    message = "There was an error."
                    
                }
                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present( alertController, animated: true, completion: nil)
            }
            
        
    }
        @objc func onRegister() {
            print("Register")
            
        }
    
    func test() {
        
        print("Worked")
      
    }
    
    func addBackButton() {
     
    }
    
    @objc func backAction(_ sender: UIButton) {

        dismiss(animated: true, completion: nil)
//       let _ = self.navigationController?.popViewController(animated: true)
    }
}

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
  
}
