//
//  LandingPageController.swift
//  LoginForm
//
//  Created by Lukas on 01.03.20.
//  Copyright © 2020 Lukas. All rights reserved.
//


import UIKit

class SignUpController: UIViewController {
    
    var username: UITextField!
           var mail: UITextField!
           var password: UITextField!
           var signUp: UIButton!
           var titleLabel: UILabel!
           var topPadding: CGFloat!
           var bottomPadding: CGFloat!

       
           override func viewDidLoad() {
               super.viewDidLoad()
               
                      if #available(iOS 11.0, *) {
                                      if let window = UIApplication.shared.keyWindow {
                                          
                                          topPadding = window.safeAreaInsets.top
                                          bottomPadding = window.safeAreaInsets.bottom
                                
                                       print(topPadding ?? 20)
                                      }
                                      }
            
               let width: CGFloat = view.frame.width
               let height: CGFloat = view.frame.height
               let formWidth: CGFloat = width/3
               let formHeight: CGFloat = height/18
               let borderWidth: CGFloat = 1
               let cornerRadius: CGFloat = 15
               let titleWidth = width * 0.8
               let spacing:CGFloat = 10
            
               
         
               mail = UITextField()
               password = UITextField()
               signUp = UIButton()
               titleLabel = UILabel()
               
               password.isSecureTextEntry = true
               
               titleLabel.text = "Sign In"
               titleLabel.textColor = tintColor
               titleLabel.textAlignment = .center
               titleLabel.font = titleFont
               
               mail.placeholder = "E-Mail"
               mail.textAlignment = .center
               password.placeholder = "Password"
               password.textAlignment = .center
               
               signUp.setTitle("Sign In", for: UIControl.State.normal)
               signUp.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
           
               
               mail.frame = CGRect(x: width/2 - titleWidth/2, y: height/spacing * 3 , width: titleWidth, height: formHeight)
               password.frame = CGRect(x: width/2 - titleWidth/2, y: height/spacing * 4 + spacing, width: titleWidth, height: formHeight)
               signUp.frame = CGRect(x: width/2  - titleWidth/2, y: height/spacing * 5 + spacing, width: titleWidth, height: formHeight)
               titleLabel.frame = CGRect(x: width/2 - formWidth/2 , y: height/spacing , width: formWidth, height: formHeight)
               signUp.layer.cornerRadius = 15
               signUp.backgroundColor = tintColor
               
       
               
               password.layer.borderWidth = borderWidth
               password.layer.cornerRadius = cornerRadius
               password.layer.borderColor = UIColor.lightGray.cgColor
     
               
               mail.layer.borderWidth = borderWidth
               mail.layer.cornerRadius = cornerRadius
               mail.layer.borderColor = UIColor.lightGray.cgColor
               
               
               signUp.addTarget(self, action: #selector(SignUpController.onSignIn), for: UIControl.Event.touchUpInside)
               

                view.addSubview(titleLabel)
               view.addSubview(password)
               view.addSubview(signUp)
               view.addSubview(mail)
            
//                      navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backAction))
                        let navBar = UINavigationBar(frame: CGRect(x: 0, y:  topPadding, width: view.frame.size.width, height: 44))
                        view.addSubview(navBar)
            //          self.navigationItem.title = "Register"
                    
                       
                        let backButton = UIButton(type: .custom)
                        backButton.setTitle("Back", for: .normal)
                        backButton.setTitleColor(backButton.tintColor, for: .normal) // You can change the TitleColor
                        backButton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)

                        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
                        navBar.setItems([navigationItem], animated: true)
             
            
           }

    
    @objc func onSignIn() {
        
        print(mail.text)
        let loginManager = FirebaseAuthManager()
        var isPerformSegue = false
        guard let email = mail.text, let password = password.text else { return }
        loginManager.signIn(email: email, pass: password) {[weak self] (success) in
            guard let self = self else { return }
            var message: String = ""
            if (success) {
//                message = "User was sucessfully logged in."
                isPerformSegue = true
                print("Logged Im")
                self.performSegue(withIdentifier: "GoToMain", sender: nil)
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
    @objc func backAction(_ sender: UIButton) {

            dismiss(animated: true, completion: nil)
    //       let _ = self.navigationController?.popViewController(animated: true)
        }
}

