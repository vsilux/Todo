//
//  HomeViewModel.swift
//  Todo
//
//  Created by Illia Suvorov on 09.06.2025.
//

import Foundation
import SimpleRoute

class HomeViewModel: ObservableObject {
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func onSettingsTapped(_ closure: @escaping RouteHandler) {
        closure(
            SettingsRoute(
                authService: FirebaseAuthService()
            )
        )
    }
}
