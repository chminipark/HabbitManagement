//
//  User.swift
//  HabbitManagement
//
//  Created by 강호성 on 2021/05/30.
//

import Foundation
import Firebase

struct User {
    let email: String
    let username: String
    let uid: String
    
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
