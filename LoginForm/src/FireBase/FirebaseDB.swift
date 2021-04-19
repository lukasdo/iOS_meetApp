//
//  FirebaseDB.swift
//  LoginForm
//
//  Created by Lukas on 02.03.20.
//  Copyright © 2020 Lukas. All rights reserved.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseAuth
import SwiftUI
public class FirebaseDB {
    let db: Firestore!

    
    init() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
    
    func addUser(values: User, key: String) {
       // [START add_ada_lovelace]
       // Add a new document with a generated ID
        let city = values
        do {
            try db.collection("user").document(key).setData(from: city)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }
    
    func addProfile(user: UserProfile) {
        
        do {
            try db.collection("user").document(user.id).setData(from: user)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }
    func uploadProfilepic(image: UIImage) {
        
        let storage = Storage.storage()
        guard let user = Auth.auth().currentUser else {
            // error
            return
        }

        // Create a storage reference from our storage service
        let storageRef = storage.reference()
        

        var data = Data()
        data = image.jpegData(compressionQuality: 0.8)!
    
        let filePath = "\(user.uid)/\("userPhoto")"
        let profileRef = storageRef.child(filePath)
        
        let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
        
       let uploadTask = profileRef.putData(data, metadata: metaData){(metaData,error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                profileRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                      // Uh-oh, an error occurred!
                        return
                        
                    }
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.photoURL = downloadURL
                    changeRequest?.commitChanges { (error) in
                      // ...
                    }
                }
                
            }
    }
    
    
    func loadImageFromFirebase(completion: @escaping (_ success: Image) -> ()){
        guard let photURL = Auth.auth().currentUser?.photoURL
            else {
                return
            }
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let profileRef = storageRef.child(Auth.auth().currentUser!.uid+"/"+"userPhoto")


        profileRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            // Uh-oh, an error occurred!
                print(error)
                let image =  Image("sophia")
                completion(image)
          } else {
            // Data for "images/island.jpg" is returned
            let uiImage = UIImage(data: data!)
            let image = Image(uiImage: uiImage!)
            completion(image)
          }
        }
        // Download to the local filesystem
//      let task = profileRef.write(toFile: localURL) { url, error in
//          if let error = error {
//            // Uh-oh, an error occurred!
//            let image =  Image("sophia")
//            completion(image)
//          } else {
//            // Local file URL for "images/island.jpg" is returned
//            let image = Image(localURL.absoluteString)
//            completion(image)
//          }
//        }
      }

    func returnProfileUrl(id: String,completion: @escaping (_ success: String?) -> ()) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let profileRef = storageRef.child(id+"/"+"userPhoto")
        profileRef.downloadURL(completion: {url,error in
            if let error = error {
                print(error)
                completion(nil)
            }
            completion(url?.absoluteString)
        })
    }
    
    func fetchProfiles(filter: String,completion: @escaping (_ success: [UserProfile],Error?) -> ()) {
        let db = Firestore.firestore().collection("user")
                
        var profileArray = [UserProfile]()
        db.getDocuments { (chatQuerySnap, error) in
            
            if let error = error {
                print("Error: \(error)")
                completion(profileArray,error)
                return
            } else {
                
                //Count the no. of documents returned
                guard let queryCount = chatQuerySnap?.documents.count else {
                    return
                }
                
                if queryCount == 0 {
                    //in case of no matches create doc
//                    self.createNewChat()
                }
                for doc in chatQuerySnap!.documents {
                    let profile = UserProfile(dictionary: doc.data())
                    if let prof = profile {
                        profileArray.append(prof)
                    }
                
                }
                completion(profileArray,nil)

                
            }
            
        }
    }
    

}
