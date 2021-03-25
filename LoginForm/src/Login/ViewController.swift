//
//  ViewController.swift
//  LoginForm
//
//  Created by Lukas on 01.03.20.
//  Copyright © 2020 Lukas. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    
    var logoImageView: UIImageView!
    var signUp: UIButton!
    var register: UIButton!
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    
 
    
    let lv_storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        // MARK:: Frame Size
        let width: CGFloat = view.frame.width
        let height: CGFloat = view.frame.height
        let formWidth: CGFloat = width/3
        let formHeight: CGFloat = height/14
        
        // MARK:: Create Elements
        logoImageView = UIImageView()
        signUp = UIButton()
        register = UIButton()
        titleLabel = UILabel()
        subtitleLabel = UILabel()
        
        //MARK:: Titles
        logoImageView.image = UIImage(named: "logo")
        logoImageView = UIImageView(image: logoImageView.image!)
        logoImageView.tintColor = tintColor
        
        titleLabel.font = titleFont
        titleLabel.text = "Welcome to ChatBot"
        titleLabel.textAlignment = .center
        titleLabel.textColor = tintColor

        subtitleLabel.font = subtitleFont
        subtitleLabel.text = "Start your iOS app."
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = subtitleColor
        
        signUp.setTitle("Sign In", for: .normal)
        signUp.setTitleColor(UIColor.lightGray, for: .normal)
        register.setTitle("Register", for: .normal)
        register.setTitleColor(UIColor.lightGray, for: .normal)
    
        //:: Frame
        let titleWidth = width * 0.8
        
        signUp.frame = CGRect(x: width/2 - titleWidth/2, y: height/10 * 3 , width: titleWidth, height: formHeight)
        signUp.layer.cornerRadius = 15
        signUp.backgroundColor = tintColor
        
        register.frame = CGRect(x: width/2 - titleWidth/2, y: height/10 * 4, width: titleWidth, height: formHeight)
        register.layer.borderWidth = 1
        register.layer.borderColor = UIColor.lightGray.cgColor  
        register.layer.cornerRadius = 15
        
       
        logoImageView.frame = CGRect(x: width/2 - formWidth/2, y: height/10 , width: formWidth, height: formHeight + 50)
        titleLabel.frame = CGRect(x: width/2  - titleWidth/2, y: height/10 + formHeight + 35, width: titleWidth, height: formHeight)
        subtitleLabel.frame = CGRect(x: width/2  - titleWidth/2, y: height/10 + formHeight + 55, width: titleWidth , height: formHeight)
        
        
        
        
        
        register.addTarget(self, action: #selector(ViewController.onRegister), for: UIControl.Event.touchUpInside)
        signUp.addTarget(self, action: #selector(ViewController.onSignUp), for: UIControl.Event.touchUpInside)
        
       
        // MARK:: SubView
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(signUp)
        view.addSubview(register)
        view.addSubview(logoImageView)
               
    }
    
    @objc func onSignUp() {
        //Alternative 1
       // performSegue(withIdentifier: "goToSignUp", sender: nil)

        //Alternative 2
        guard let signUpVC = lv_storyboard.instantiateViewController(withIdentifier: "SignUpController") as? SignUpController else { return;}
        signUpVC.modalPresentationStyle = .fullScreen
        self.present(signUpVC, animated: true)
        
        //Alternative 3
//        let newVC = SignUpController()
//        self.navigationController?.pushViewController(newVC, animated: true)

    }
    
    @objc func onRegister() {
        print("Register")
        
//        performSegue(withIdentifier: "goToRegister", sender: nil)
        
        guard let registerVC = lv_storyboard.instantiateViewController(withIdentifier: "RegisterController") as? RegisterController else { return;}
        registerVC.modalPresentationStyle = .fullScreen
            self.present(registerVC, animated: true)
    }


}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

