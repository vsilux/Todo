//
//  SignupUseCase.swift
//  Todo
//
//  Created by Illia Suvorov on 10.06.2025.
//

import Foundation

protocol SignupUseCase {
    func execute(email: String, password: String) async throws -> User
}

class DefaultSignupUseCase: SignupUseCase {
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func execute(email: String, password: String) async throws -> User {
        return try await authService.signup(email: email, password: password)
    }
}
