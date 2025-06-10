//
//  UserStore.swift
//  Todo
//
//  Created by Illia Suvorov on 10.06.2025.
//

import Foundation
import Combine

protocol UserStore {
    var currentUser: User? { get }
    var userPublisher: AnyPublisher<User?, Never> { get }
        
    func store(_ user: User?)
    func signOut()
}

class DefaultUserStore: UserStore {
    @Published private(set) var currentUser: User?
    
    var userPublisher: AnyPublisher<User?, Never> {
        $currentUser.eraseToAnyPublisher()
    }
    
    func store(_ user: User?) {
        self.currentUser = user
    }
        
    func signOut() {
        self.currentUser = nil
    }
}
