//
//  DefaultDependencyContainer.swift
//  Todo
//
//  Created by Illia Suvorov on 10.06.2025.
//

import Foundation

class DefaultDependencyContainer: DependencyContainer {
    // MARK: - Services
    lazy var authService: AuthService = FirebaseAuthService()
        
    lazy var userStore: UserStore = DefaultUserStore()
    
    // MARK: - Use Cases
    var loginUseCase: LoginUseCase {
        DefaultLoginUseCase(
            authService: authService,
            userStore: userStore
        )
    }
    
    var signupUseCase: SignupUseCase {
        DefaultSignupUseCase(
            authService: authService,
            userStore: userStore
        )
    }
    
    var logoutUseCase: LogoutUseCase {
        DefaultLogoutUseCase(
            authService: authService,
            userStore: userStore
        )
    }
}

