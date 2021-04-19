//
//  SwiftUISignUp.swift
//  LoginForm
//
//  Created by Lukas on 28.03.21.
//  Copyright © 2021 Lukas. All rights reserved.
//


import SwiftUI

struct SwiftUISignUp: View {
 
    var logged = false
    var body: some View {
        
        NavigationView{
            
//            if logged {
//                Text("user Logged in")
//            } else {
                Register()
                    .preferredColorScheme(.dark)
                    .navigationBarHidden(true)
//            }
            
        }
    }
}

struct SwiftUISignUp_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUISignUp()
    }
}

struct Register: View {
    
    @State var showSignIn = false
    @State var willCallFunc = false
    @State var userName = ""
    @State var password = ""
    @State var name = ""
    
    @State  var isEmailValid : Bool   = true
    
//    @AppStorage("stored_User") var user = "STORED_MAIL"
//    @AppStorage("status") var logged = false
    
    
    var body: some View {
//
        if #available(iOS 14.0, *) {
           
            VStack {
                RegisterUIController(showSignin: $showSignIn, username: $userName, password: $password, name: $name, calledFunc: $willCallFunc)
                Spacer(minLength: 15)
                
                //            Image("logo")
                //                .resizable()
                //                .aspectRatio(contentMode: .fit)
                //                .padding(.horizontal,35)
                //                .padding(.vertical)
                
                HStack {
                    VStack( alignment: .leading, spacing: 12, content: {
                        Text("Register")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text("Register to continue")
                            .foregroundColor(.white)
                    })
                    
                    Spacer(minLength: 0)
                }
                .padding()
                .padding(.leading,15)
                
                HStack {
                    Image("envelope")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .font(.title2)
                        
                        .foregroundColor(.white)
                        .frame(width: 35)
                    TextField("E-mail", text: $userName, onEditingChanged: { (isChanged) in
                        if !isChanged {
                            if self.textFieldValidatorEmail(self.userName) {
                                self.isEmailValid = true
                            } else {
                                self.isEmailValid = false
                                self.userName = ""
                   
                            }
                        }
                        })
                    
                       
                    if !self.isEmailValid {
                               Text("Email is Not Valid")
                                   .font(.callout)
                                   .foregroundColor(Color.red)
                           }
                }
                .padding()
                .background(Color.white.opacity(0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                
                HStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .font(.title2)
                        
                        .foregroundColor(.white)
                        .frame(width: 35)
                    TextField("Name", text: $userName)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(0.12))
                .cornerRadius(15)
                .padding(.horizontal)
        
                HStack {
                    Image("lock")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .font(.title2)
                        
                        .foregroundColor(.white)
                        .frame(width: 35)
                    SecureField("Password", text: $password)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(0.12))
                .cornerRadius(15)
                .padding(.horizontal)
      
                
                HStack {
                    Image("lock")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .font(.title2)
                        
                        .foregroundColor(.white)
                        .frame(width: 35)
                    SecureField("Repeat password", text: $password)
                    
                }
                .padding()
                .background(Color.white.opacity(0.12))
                .cornerRadius(15)
                .padding(.horizontal)
         
            
                
                HStack(spacing: 15) {
                    Button(action: {
          
                        self.willCallFunc = true
                    }, label: {
                        Text("Register")
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 150)
                            .background(Color(.cyan))
                            .clipShape(Capsule())
                    })
                    .opacity((userName != "" && password != "" ? 1 : 0.5))
                    .disabled((userName != "" && password != "" ? false : true))
                }
                
          
                //
                
                .padding(.top)
                //        Spacer()
                //        Spacer(minLength: 0)
                HStack(spacing:5) {
                    Text("Already have an account?")
                    //                .foregroundColor(Color.white.opacity(0.6))
                    Button(action: {showSignIn = true}, label: {
                        Text("Sign in")
                            .fontWeight(.heavy)
                            .foregroundColor(Color(.cyan))
                    })
                }
                .padding(.vertical)
                Spacer(minLength: 30)
            }
            .background( LinearGradient(gradient: Gradient(colors: [Color(UIColor(red: 6/255, green: 0/255, blue: 58/255, alpha: 1.0)),
                                                                    Color(UIColor(red: 0/255, green: 31/255, blue: 89/255, alpha: 1.0))]),  startPoint: .bottomTrailing, endPoint: .topLeading)).edgesIgnoringSafeArea(.all)
        } else {
            // Fallback on earlier versions
        }
    
        
////                if getBioMetric
//            }
//            padding(.top,8)
//            Spacer(minLength: 0)
//            HStack(spacing: 5) {
//
//            }
            
            
        

    }
    func textFieldValidatorEmail(_ string: String) -> Bool {
            if string.count > 100 {
                return false
            }
            let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
            //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
            return emailPredicate.evaluate(with: string)
    }

    func authUser() {
        
    }
}
