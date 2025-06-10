//
//  MockAuthService.swift
//  Todo
//
//  Created by Illia Suvorov on 05.06.2025.
//

import Foundation

class MockAuthService: AuthService {
    
    var user: User? = nil
    
    var loginClosure: ((String, String) async throws -> User)?
    var signupClosure: ((String, String) async throws -> User)?
    
    init(
        loginClosure: ((String, String) async throws -> User)? = nil,
        signupClosure: ((String, String) async throws -> User)? = nil
    ) {
        self.loginClosure = loginClosure
        self.signupClosure = signupClosure
    }
    
    func login(email: String, password: String) async throws -> User {
        try await loginClosure?(email, password) ?? .dummy
    }
    
    func signup(email: String, password: String) async throws -> User {
        try await signupClosure?(email, password) ?? .dummy
    }
    
    func logout() async {
        self.user = nil
    }
}
