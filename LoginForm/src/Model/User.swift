//
//  User.swift
//  LoginForm
//
//  Created by Lukas on 26.03.21.
//  Copyright © 2021 Lukas. All rights reserved.
//

import Foundation


import Firebase
import MessageKit

struct Matches {
    var id: String
    var mail: String
  
    var dictionary: [String: Any] {
return [
    "id": id,
    "mail": mail]
    }
}

extension Matches {
    init?(dictionary: [String: Any]) {
    guard let id = dictionary["id"] as? String,
        let mail = dictionary["mail"] as? String
    else {return nil}
        
    self.init(id: id, mail: mail)
    }
}
