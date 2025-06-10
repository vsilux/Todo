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
    private let userStore: UserStore
    
    init(
        authService: AuthService,
        userStore: UserStore
    ) {
        self.authService = authService
        self.userStore = userStore
    }
    
    @discardableResult
    func execute(email: String, password: String) async throws -> User {
        let user = try await authService.signup(email: email, password: password)
        userStore.store(user)
        return user
    }
}
