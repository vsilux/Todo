//
//  SettingsViewModel.swift
//  Todo
//
//  Created by Illia Suvorov on 09.06.2025.
//

import Foundation

class SettingsViewModel: ObservableObject {
    private let logoutUseCase: LogoutUseCase
    
    init(logoutUseCase: LogoutUseCase) {
        self.logoutUseCase = logoutUseCase
    }
    
    func logout(_ completion: @escaping () -> Void) {
        Task {
            do {
                try await logoutUseCase.execute()
                await MainActor.run {
                    completion()
                }
            } catch {
                print("Error during logout: \(error)")
            }
        }
    }
}
