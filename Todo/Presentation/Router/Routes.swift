//
//  Route.swift
//  Todo
//
//  Created by Illia Suvorov on 08.06.2025.
//

import Foundation
import SwiftUI
import SimpleRoute

enum RouteId: Hashable {
    case login
    case signup
    case home
    case settings
}

@RouteModel
struct LoginRoute: Route {
    var id: RouteId { .login }
    
    @ViewBuilder
    var destination: some View {
        LoginView()
    }
}

@RouteModel
struct SignupRoute: Route {
    var id: RouteId { .signup }
    
    @ViewBuilder
    var destination: some View {
        SignupView()
    }
}

@RouteModel
struct HomeRoute: Route {
    var id: RouteId { .home }
    var user: User
    
    @ViewBuilder
    var destination: some View {
        HomeView(viewModel: HomeViewModel(user: user)) // Replace with actual home view
    }
}

@RouteModel
struct SettingsRoute: Route {
    var id: RouteId { .settings } // Assuming settings is part of home for simplicity
    
    @ViewBuilder
    var destination: some View {
        SettingsView()
    }
}
