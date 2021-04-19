//
//  UserProfile.swift
//  LoginForm
//
//  Created by Lukas on 12.04.21.
//  Copyright © 2021 Lukas. All rights reserved.
//
import SwiftUI
import Foundation

struct UserProfile : Encodable  {
    var id: String
    var image: String?
    var name: String
    var dictionary: [String: Any] {
   return [
       "id": id,
       "image": image,
        "name": name]
       }
}
extension UserProfile {
    init?(dictionary: [String: Any]) {
    guard let id = dictionary["id"] as? String,
        let image = dictionary["image"] as? String,
        let name = dictionary["name"] as? String
       
    else {return nil}

        self.init(id: id,image: image, name: name)
    }

}
