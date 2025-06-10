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
    case home
    case settings
}

@RouteModel
struct HomeRoute: Route {
    let id: RouteId = .home
    var dependencyContainer: DependencyContainer
    
    var destination: some View {
        HomeView(
            container: dependencyContainer,
        )
    }
}

@RouteModel
struct SettingsRoute: Route {
    let id: RouteId = .settings
    var dependencyContainer: DependencyContainer
    
    var destination: some View {
        SettingsView(
            container: dependencyContainer
        )
    }
}
