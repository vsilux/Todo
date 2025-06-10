//
//  User.swift
//  Todo
//
//  Created by Illia Suvorov on 04.06.2025.
//

import Foundation

struct User: Identifiable {
    var id: String { return uid }
    
    var uid: String
    var displayName: String?
    var photoURL: URL?
    var email: String?
    var phoneNumber: String?
}

extension User {
    static let dummy = User(uid: "dummy")
}
