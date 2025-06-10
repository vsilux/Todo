//
//  SettingsViewModel.swift
//  Todo
//
//  Created by Illia Suvorov on 09.06.2025.
//

import Foundation

class SettingsViewModel: ObservableObject {
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func logout(_ completion: @escaping () -> Void) {
        Task {
            await authService.logout()
            await MainActor.run {
                completion()
            }
        }
    }
}
