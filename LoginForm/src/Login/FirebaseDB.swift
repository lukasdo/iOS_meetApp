//
//  FirebaseDB.swift
//  LoginForm
//
//  Created by Lukas on 02.03.20.
//  Copyright © 2020 Lukas. All rights reserved.
//

import Foundation

import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift


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
}
