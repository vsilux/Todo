//
//  InitialViewModel.swift
//  Todo
//
//  Created by Illia Suvorov on 09.06.2025.
//

import Foundation
import SimpleRoute

class AuthViewModel: ObservableObject {
    @Published var isLoading: Bool = true
    
    let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func checkIsAuthorized(_ closure: @escaping RouteHandler) {
        if let user = authService.user {
            closure(HomeRoute(user: user))
        }
    }
    
    func onLoginTapped(_ closure: @escaping RouteHandler) {
        closure(LoginRoute())
    }
    
    func onSignupTapped(_ closure: @escaping RouteHandler) {
        closure(SignupRoute())
    }
}
