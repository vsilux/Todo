//
//  AuthUseCase.swift
//  Todo
//
//  Created by Illia Suvorov on 10.06.2025.
//

import Foundation

protocol LoginUseCase {
    func execute(email: String, password: String) async throws -> User
}

class DefaultLoginUseCase: LoginUseCase {
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func execute(email: String, password: String) async throws -> User {
        return try await authService.login(email: email, password: password)
    }
}
