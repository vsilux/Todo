//
//  LogoutUseCase.swift
//  Todo
//
//  Created by Illia Suvorov on 10.06.2025.
//

import Foundation

protocol LogoutUseCase {
    func execute() async throws
}

class DefaultLogoutUseCase: LogoutUseCase {
    private let authService: AuthService
    private let userStore: UserStore
    
    init(
        authService: AuthService,
        userStore: UserStore
    ) {
        self.authService = authService
        self.userStore = userStore
    }
    
    func execute() async throws {
        try await authService.logout()
        userStore.signOut()
    }
}
