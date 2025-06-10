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
        let user = try await authService.login(email: email, password: password)
        userStore.store(user)
        return user
    }
}
