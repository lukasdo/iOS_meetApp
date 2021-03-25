//
//  RegisterController.swift
//  LoginForm
//
//  Created by Lukas on 01.03.20.
//  Copyright © 2020 Lukas. All rights reserved.
//

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

class RegisterController: UIViewController {

        var username: UITextField!
        var lastName: UITextField!
        var firstName: UITextField!
        var mail: UITextField!
        var password: UITextField!
        var passwordTwo: UITextField!
        var signUp: UIButton!
        var titleLabel: UILabel!
     var topPadding: CGFloat!
     var bottomPadding: CGFloat!


    var newSafeArea: UIEdgeInsets!
    
    override func viewWillAppear(_ animated: Bool) {

    }
    

        

        override func viewDidLoad() {
            super.viewDidLoad()
            print("ViewDidLoad")
            if #available(iOS 11.0, *) {
                            if let window = UIApplication.shared.keyWindow {
                                
                                topPadding = window.safeAreaInsets.top
                                bottomPadding = window.safeAreaInsets.bottom
                      
                             print(topPadding ?? 20)
                            }
                            }
  

             let width: CGFloat = view.frame.width
            let height: CGFloat = view.frame.height

           let layer = CAGradientLayer()
            layer.frame = CGRect(x: 0 , y: 0, width: width, height: height)
            layer.colors = [UIColor.blue.cgColor,UIColor.purple.cgColor]
//            view.layer.addSublayer(layer)
            
            let formWidth: CGFloat = width/3
            let formHeight: CGFloat = height/18
            let borderWidth: CGFloat = 1
            let cornerRadius: CGFloat = 15
            let titleWidth = width * 0.8
            let spacing:CGFloat = height/1000
            let const:CGFloat = 11
            
            username = UITextField()
            username.placeholder = "Username"
            username.textAlignment = .center
            username.layer.borderWidth = borderWidth
            username.layer.cornerRadius = cornerRadius
            username.layer.borderColor = fontColor
            
            lastName = UITextField()
            lastName.placeholder = "Last Name"
            lastName.textAlignment = .center
            lastName.layer.borderWidth = borderWidth
            lastName.layer.cornerRadius = cornerRadius
            lastName.layer.borderColor = fontColor
            
            firstName = UITextField()
            firstName.placeholder = "First Name"
            firstName.textAlignment = .center
            firstName.layer.borderWidth = borderWidth
            firstName.layer.cornerRadius = cornerRadius
            firstName.layer.borderColor = fontColor
            
            mail = UITextField()
            mail.placeholder = "E-Mail"
            mail.textAlignment = .center
            mail.layer.borderWidth = borderWidth
            mail.layer.cornerRadius = cornerRadius
            mail.layer.borderColor = fontColor
                
            password = UITextField()
            password.placeholder = "Password"
            password.textAlignment = .center
            password.isSecureTextEntry = true
            password.layer.borderWidth = borderWidth
            password.layer.cornerRadius = cornerRadius
            password.layer.borderColor = fontColor
            
            passwordTwo = UITextField()
            passwordTwo.placeholder = "Password again"
            passwordTwo.textAlignment = .center
            passwordTwo.isSecureTextEntry = true
            passwordTwo.layer.borderWidth = borderWidth
            passwordTwo.layer.cornerRadius = cornerRadius
            passwordTwo.layer.borderColor = fontColor
            
            signUp = UIButton()
            signUp.setTitle("Sign Up", for: UIControl.State.normal)
            signUp.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
            signUp.layer.cornerRadius = 15
            signUp.backgroundColor = tintColor
            
            titleLabel = UILabel()
            titleLabel.text = "Sign Up"
            titleLabel.textColor = tintColor
            titleLabel.font = titleFont
            titleLabel.textAlignment = .center

            
        
//            titleLabel.frame = CGRect(x: width/2 - formWidth/2, y: width/9 , width: formWidth, height: formHeight)
            username.frame = CGRect(x: width/2 - titleWidth/2, y: height/const * 2 + spacing, width: titleWidth, height: formHeight)
            firstName.frame = CGRect(x: width/2 - titleWidth/2, y: height/const * 3 + spacing, width: titleWidth, height: formHeight)
            lastName.frame = CGRect(x: width/2 - titleWidth/2, y: height/const * 4 + spacing , width: titleWidth, height: formHeight)
            mail.frame = CGRect(x: width/2 - titleWidth/2, y: height/const * 5 + spacing , width: titleWidth, height: formHeight)
            password.frame = CGRect(x: width/2 - titleWidth/2, y: height/const * 6 + spacing , width: titleWidth, height: formHeight)
            passwordTwo.frame = CGRect(x: width/2 - titleWidth/2, y: height/const * 7 + spacing, width: titleWidth, height: formHeight)
            signUp.frame = CGRect(x: width/2  - titleWidth/2, y: height/const * 8 + spacing , width: titleWidth, height: formHeight)
            
    
            
            signUp.addTarget(self, action: #selector(ViewController.onSignUp), for: UIControl.Event.touchUpInside)
            
            view.addSubview(username)
            view.addSubview(password)
            view.addSubview(lastName)
            view.addSubview(firstName)
            view.addSubview(signUp)
            view.addSubview(passwordTwo)
            view.addSubview(mail)
            view.addSubview(titleLabel)
            
//            let backButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.rewind, target: self, action: #selector(self.backAction(_:)))
//
//            navigationItem.backBarButtonItem = backButton

//            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backAction))
            let navBar = UINavigationBar(frame: CGRect(x: 0, y: topPadding, width: view.frame.size.width, height: 44))
            view.addSubview(navBar)
//          self.navigationItem.title = "Register"
        
           
            let backButton = UIButton(type: .custom)
            backButton.setTitle("Back", for: .normal)
            backButton.setTitleColor(backButton.tintColor, for: .normal) // You can change the TitleColor
            backButton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)

            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
            navBar.setItems([navigationItem], animated: true)
 
            

                   
        }
        
        
    @objc func onSignUp() {
        let db = FirebaseDB()
        let signUpManager = FirebaseAuthManager()
        if let email = mail.text, let password = password.text, let fname = firstName.text, let lname = lastName.text {
            if password == passwordTwo.text && email.isValidEmail() {
                print("Email: " + email + " PW: " + password)
            signUpManager.createUser(email: email, password: password) {[weak self] (success) in
                guard let self = self
                    else { return }
                var message: String = ""
                if (success) {
                    message = "User was sucessfully created."
                    let user = User(first: fname, last: lname, mail: email)
//                    TODO:: Name wegspeichern
                    db.addUser(values: user, key: email)
                    
                } else {
                    message = "There was an error."
                    
                }
                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present( alertController, animated: true, completion: nil)
            }
            }
        }
    }
        @objc func onRegister() {
            print("Register")
            
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
