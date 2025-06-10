//
//  Route.swift
//  Todo
//
//  Created by Illia Suvorov on 08.06.2025.
//

import Foundation
import SwiftUI

enum Route: Hashable {
    case login
    case signup
    case home
    case settings
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .login:
            LoginView()
        case .signup:
            SignupView()
        case .home:
            HomeView()
        case .settings:
            SettingsView()
        }
    }
}

class Router: ObservableObject {
    @Published var routes: [Route] = []
    
    var canPop: Bool {
        !routes.isEmpty
    }
    
    func navigate(to route: Route) {
        routes.append(route)
    }
    
    func navigateBack() {
        guard !routes.isEmpty else { return }
        routes.removeLast()
    }
    
    func navigateBackToRoot() {
        routes.removeAll()
    }
    
    func navigateBack(to route: Route) {
        guard let index = routes.lastIndex(of: route) else { return }
        routes.removeSubrange(index..<routes.count)
    }
}

struct RouterKey: EnvironmentKey {
    nonisolated(unsafe) static let defaultValue: Router = Router()
}

extension EnvironmentValues {
    var router: Router {
        get { self[RouterKey.self] }
        set { self[RouterKey.self] = newValue }
    }
}
