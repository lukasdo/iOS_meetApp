//
//  LandingPageController.swift
//  LoginForm
//
//  Created by Lukas on 01.03.20.
//  Copyright © 2020 Lukas. All rights reserved.
//

import SwiftUI
import UIKit

struct SwiftUIViewController: UIViewControllerRepresentable {

        
    @Binding var isCallingFunc: Bool
    @Binding var username: String
    @Binding var passwd: String
    
    typealias UIViewControllerType = SignUpController
    
    
       class Coordinator {
           var previousClickID: Bool? = false
       }
       
       func makeCoordinator() -> Coordinator {
           return Coordinator()
       }

    func makeUIViewController(context: Context) -> SignUpController {
////        makeUIViewController(context: context)
        let controller = SignUpController()
        // callback to provide active component to caller

        return controller

    }

    func updateUIViewController(_ uiViewController: SignUpController, context: Context) {
        print("UpdateViewContrl")
        if isCallingFunc {
            print("Test")
            uiViewController.onSignIn(password: passwd, mail: username)
            isCallingFunc = false
        }
        isCallingFunc = false
    }

}

class SignUpController: UIViewController {
    
 


    override func viewDidLoad() {
               super.viewDidLoad()
            
            
//               let swiftUIController = UIHostingController(rootView: ContentView())
//               addChild(swiftUIController)
//
//                swiftUIController.view.frame =    self.view.bounds
//            self.view.addSubview(swiftUIController.view)
//                swiftUIController.didMove(toParent: self)
               
//                      if #available(iOS 11.0, *) {
//                                      if let window = UIApplication.shared.keyWindow {
//
//                                          topPadding = window.safeAreaInsets.top
//                                          bottomPadding = window.safeAreaInsets.bottom
//
//                                       print(topPadding ?? 20)
//                                      }
//                                      }
//
           }

    
     func onSignIn(password: String, mail: String) {
        

        let loginManager = FirebaseAuthManager()
        var isPerformSegue = false
        
        loginManager.signIn(email: mail, pass: password) {[weak self] (success) in
            guard let self = self else { return }
            var message: String = ""
            if (success) {
//                message = "User was sucessfully logged in."
                isPerformSegue = true
                print("Logged Im")
                

                self.navigationController?.pushViewController(AppController(), animated: true)
//
            } else {
                message = "There was an error."
                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present( alertController, animated: true, completion: nil)
            }}
        print(isPerformSegue)
        if isPerformSegue == true {
            print("Perform Segue")


        }
    }
    
    @objc func test() {
        
        print("Worked")
      
    }
    @objc func backAction(_ sender: UIButton) {

            dismiss(animated: true, completion: nil)
    //       let _ = self.navigationController?.popViewController(animated: true)
        }
}
