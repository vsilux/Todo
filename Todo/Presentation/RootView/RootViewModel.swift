//
//  RootViewModel.swift
//  Todo
//
//  Created by Illia Suvorov on 09.06.2025.
//

import Foundation
import SimpleRoute

class RootViewModel: ObservableObject {
    private let authService: AuthService
    @Published var user: User?
    @Published var isLoading: Bool = true
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func checkIsAuthorized() {
        isLoading = true
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.user = self.authService.user
            self.isLoading = false
        }
    }
    
    func getHomeViewModel() -> HomeViewModel {
        // Safe to force unwrap since this should only be called when user exists
        return HomeViewModel(user: user!)
    }
        
    func getAuthViewModel() -> AuthViewModel {
        return AuthViewModel(authService: authService)
    }
}
