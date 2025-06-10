//
//  DependencyContainer.swift
//  Todo
//
//  Created by Illia Suvorov on 10.06.2025.
//

import Foundation

protocol DependencyContainer {
    var authService: AuthService { get }
        
    var userStore: UserStore { get }
    
    // MARK: - Use Cases
    var loginUseCase: LoginUseCase {get }
    var signupUseCase: SignupUseCase { get }
    var logoutUseCase: LogoutUseCase { get }
}
