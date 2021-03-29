//
//  Chat.swift
//  LoginForm
//
//  Created by Lukas on 05.03.20.
//  Copyright © 2020 Lukas. All rights reserved.
//

import UIKit

struct Chat {
    var users: [String]
    var dictionary: [String: Any] {
    return ["users": users]
   }
}

extension Chat {
    init?(dictionary: [String:Any]) {
    guard let chatUsers = dictionary["users"] as? [String]
        else {return nil}
    self.init(users: chatUsers)
}
}
