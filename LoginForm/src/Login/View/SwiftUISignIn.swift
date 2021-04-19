//
//  SwiftUIView.swift
//  LoginForm
//
//  Created by Lukas on 27.03.21.
//  Copyright © 2021 Lukas. All rights reserved.
//

import SwiftUI

struct ContentView: View {
 
    var logged = false
    var body: some View {
        
        NavigationView{
            
//            if logged {
//                Text("user Logged in")
//            } else {
                Home()
                    .preferredColorScheme(.dark)
                    .navigationBarHidden(true)
//            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    @State var showSignUp = false
    @State var willCallFunc = false
    @State var userName = ""
    @State var password = ""
    
    
    
    
//    @AppStorage("stored_User") var user = "STORED_MAIL"
//    @AppStorage("status") var logged = false
    
    
    var body: some View {
//
        if #available(iOS 14.0, *) {
           
            VStack {
                SwiftUIViewController(showSignUp: $showSignUp,isCallingFunc: $willCallFunc, username: $userName, passwd: $password)
                Spacer(minLength: 15)
                
                //            Image("logo")
                //                .resizable()
                //                .aspectRatio(contentMode: .fit)
                //                .padding(.horizontal,35)
                //                .padding(.vertical)
                
                HStack {
                    VStack( alignment: .leading, spacing: 12, content: {
                        Text("Login")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text("Sign in to continue")
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
                    TextField("E-mail", text: $userName)
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity( 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                //
                HStack {
                    Image("lock")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .font(.title2)
                        
                        .foregroundColor(.white)
                        .frame(width: 35)
                    SecureField("Password", text: $password)
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity( 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.top)
                
                HStack(spacing: 15) {
                    Button(action: {
          
                        self.willCallFunc = true
                    }, label: {
                        Text("Login")
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
                
                Button(action: {}, label: {
                    Text("Forget password?")
                }).padding(.top,8)
                //
                
                .padding(.top)
                //        Spacer()
                //        Spacer(minLength: 0)
                HStack(spacing:5) {
                    Text("Dont have an account?")
                    //                .foregroundColor(Color.white.opacity(0.6))
                    Button(action: {showSignUp = true}, label: {
                        Text("Signup")
                            .fontWeight(.heavy)
                            .foregroundColor(Color(.cyan))
                    })
                }
                .padding(.vertical)
                Spacer(minLength: 30)
            }
            .background( LinearGradient(gradient: Gradient(colors: [Color(UIColor(red: 6/255, green: 0/255, blue: 58/255, alpha: 1.0)),
                                                                    Color(UIColor(red: 0/255, green: 31/255, blue: 89/255, alpha: 1.0))]),  startPoint: .bottomTrailing, endPoint: .top)).edgesIgnoringSafeArea(.all)
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
    
    func authUser() {
        
    }
}
