//
//  User.swift
//  WA8
//
//  Created by Sai Vihar Reddy Gunamgari on 11/3/25.
//

import Foundation

struct User: Codable {
    var uid: String?
    var name: String
    var email: String
    
    init(uid: String? = nil, name: String, email: String) {
        self.uid = uid
        self.name = name
        self.email = email
    }
}
