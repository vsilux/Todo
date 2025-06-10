//
//  AuthRoute.swift
//  Todo
//
//  Created by Illia Suvorov on 10.06.2025.
//

import Foundation
import SwiftUI
import SimpleRoute

enum AuthRouteId: Hashable {
    case login
    case signup
}

@RouteModel
struct LoginRoute: Route {
    let id: AuthRouteId = .login
    var dependencyContainer: DependencyContainer
    
    var destination: some View {
        LoginView(
            container: dependencyContainer,
        )
    }
}

@RouteModel
struct SignupRoute: Route {
    let id: AuthRouteId = .signup
    var dependencyContainer: DependencyContainer
    
    var destination: some View {
        SignupView(
            container: dependencyContainer,
        )
    }
}

