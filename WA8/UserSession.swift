//
//  UserSession.swift
//  WA8
//
//  Created by Sai Vihar Reddy Gunamgari on 11/5/25.
//

import Foundation

final class UserSession {
    static let shared = UserSession()
    
    private init() {}
    
    var currentUser: User?
}
