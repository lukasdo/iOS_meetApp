//
//  FireBaseAuth.swift
//  LoginForm
//
//  Created by Lukas on 02.03.20.
//  Copyright © 2020 Lukas. All rights reserved.
// TODO:: Sign in with Apple
// https://firebase.google.com/docs/auth/ios/apple?authuser=0

import UIKit
import FirebaseAuth

public class FirebaseAuthManager {
    
    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool, _ user: FirebaseAuth.User?) -> Void) {
        
//        Auth.auth().currentUser.photo
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                print(user)
               
                completionBlock(true,user)
              
    
            } else {
                completionBlock(false,nil)
     
            }
        }
        
    }
    
    func signIn(email: String, pass: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
    
    
}
