//
//  UserProfileView.swift
//  LoginForm
//
//  Created by Lukas on 29.03.21.
//  Copyright © 2021 Lukas. All rights reserved.
//


import SwiftUI
import FirebaseAuth
import FirebaseStorage

struct UserProfileView: View {
    
    @State var name: String
    @State private var image: Image? = Image("sophia")

    var sb:UIStoryboard?
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    
    @State private var likesFootball = false
    @State private var likesSoftware = false

    
        @Environment(\.colorScheme) var colorScheme
        var body: some View {
            if #available(iOS 14.0, *) {
                NavigationView {
                    
                    List {
                        
                        Section{
                            VStack (alignment: .center){
                                image?
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                    .shadow(radius: 10)
                                    .onTapGesture { self.shouldPresentActionScheet = true }
                                    .padding(.horizontal,10)
                                    .onAppear{
                                        FirebaseDB().loadImageFromFirebase{ image in
                                            self.image = image
                                        }
                                    }
                                    .sheet(isPresented: $shouldPresentImagePicker) {
                                        SUImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, image: self.$image, isPresented: self.$shouldPresentImagePicker)
                                }.actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
                                    ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                                        self.shouldPresentImagePicker = true
                                        self.shouldPresentCamera = true
                                    }), ActionSheet.Button.default(Text("Photo Library"), action: {
                                        self.shouldPresentImagePicker = true
                                        self.shouldPresentCamera = false
                                    }), ActionSheet.Button.cancel()])
                                }
                            }
                         
                                }
                        
                        
                        
                        Section {
                            Text("Name")
                                .fontWeight(.bold)
                           TextField("Name", text: $name)
                        }
                        
                        
                        Section {
                            Text("Company")
                                .fontWeight(.bold)
                           TextField("company", text: $name)
                            
                            Text("Job title")
                                .fontWeight(.bold)
                           TextField("job title", text: $name)
                        }
                        
                        HStack {
                            Button(
                                action: {}, label: {
                                Text("Software")
//                                    .fontWeight(.)
                                    .foregroundColor(.black)
                                    .padding(.vertical)
                                    .frame(width: 70,height: 30)
                                    
                                    .background(Color(.white))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                    .stroke(likesSoftware ? Color.blue : Color.gray, lineWidth: 2)
                                           
                        )
                            }) .onTapGesture{
                                self.likesSoftware = !self.likesSoftware
                            }
                            Button(action: {
                            }, label: {
                                Text("Football")
//                                    .fontWeight(.)
                                    .foregroundColor(.black)
                                    .padding(.vertical)
                                    .frame(width: 70,height: 30)
                                    
                                    .background(Color(.white))
                                    .overlay(
                                                  RoundedRectangle(cornerRadius: 25)
                                                    .stroke( likesFootball ? Color.blue : Color.gray, lineWidth: 2)
                                          )
                            })
                            .onTapGesture{
                                self.likesFootball = !self.likesFootball
                            }
                        }
         
                        
                        
                        Section {
                            Button(action: {},
                                   label: {
                                    SettingsCell(title: "Features", imgName: "sparkle", clr: .purple)
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                   })
                            
                            Button(action: {},
                                   label: {
                                    SettingsCell(title: "Settings", imgName: "sparkle", clr: .purple)
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                   })
                        }
                        
                        Section {
                            Button(action: {},
                                   label: {
                                    SettingsCell(title: "Leave a feedback", imgName: "sparkle", clr: .purple)
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                   })
                         
                        }
                    }
                    HStack(spacing: 15) {
                        Button(action: {
//                            do {
//                                try Auth.auth().signOut()
////                                if let vc = self.sb?.instantiateViewController(identifier: "§") {
////                                    self.
////                                    self.viewObj?.window?.rootViewController = vc
////                                    self.sb?.
//                                }
//                            }
//                            catch {
//
//                            }
                        
                        }, label: {
                            Text("Logout")
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 150)
                                .background(Color(.blue))
                                .clipShape(Capsule())
                        })
                         }
                    
                }
     
                //        .environment(\.horizontalSizeClass, .regular)
                .navigationTitle("Create account")
                .navigationBarItems(trailing: HStack {
                    Button("Done") {
                        let databaseWrapper = FirebaseDB()
                        let user = UserProfile(id: Auth.auth().currentUser!.uid, image: "imgPath", name: name)
                        databaseWrapper.addProfile(user: user)
                        
                    }
                })
            }
        }

}


struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(name: "Name")
    }
}


