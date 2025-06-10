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
}

@RouteModel
struct LoginRoute: Route {
    var id: RouteId { .login }
    let authService: AuthService
    
    @ViewBuilder
    var destination: some View {
        LoginView(viewModel: LoginViewModel(loginUseCase: DefaultLoginUseCase(authService: authService)))
    }
}

@RouteModel
struct SignupRoute: Route {
    var id: RouteId { .signup }
    let authService: AuthService
    
    @ViewBuilder
    var destination: some View {
        SignupView(viewModel: SignupViewModel(sigupUseCase: DefaultSignupUseCase(authService: authService)))
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
    var id: RouteId { .home } // Assuming settings is part of home for simplicity
    let authService: AuthService
    
    @ViewBuilder
    var destination: some View {
        SettingsView(viewModel: SettingsViewModel(authService: authService))
    }
}

//extension Route {
//    @ViewBuilder
//    var destination: some View {
//        switch self {
//        case .login(let loginService):
//            LoginView(viewModel: LoginViewModel(loginService: loginService))
//        case .signup(let signupService):
//            SignupView(viewModel: SignupViewModel(signupService: signupService))
//        case .home:
//            Text("Home View") // Replace with actual home view
//        }
//    }
//}

