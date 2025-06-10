//
//  RootViewModel.swift
//  Todo
//
//  Created by Illia Suvorov on 09.06.2025.
//

import Foundation

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
}
