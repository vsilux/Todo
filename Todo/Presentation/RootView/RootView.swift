//
//  RootView.swift
//  Todo
//
//  Created by Illia Suvorov on 09.06.2025.
//

import Foundation
import SwiftUI
import SimpleRoute

struct RootView: View {
    @StateObject private var authRouter: Router = Router()
    @StateObject private var router: Router = Router()
    @StateObject private var viewModel: RootViewModel
    
    @Environment(\.dependancyContainer) var container
    
    init(container: DependencyContainer) {
        _viewModel = StateObject(
            wrappedValue: RootViewModel(
                authService: container.authService,
                userStore: container.userStore,
            )
        )
    }
    
    var body: some View {
        
        ZStack {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            }
            VStack {
                if viewModel.user != nil {
                    NavigationStack(path: $router.routes) {
                        HomeView(container: container)
                            .navigationDestination(for: AnyRoute.self) { route in
                                route.destination
                            }
                            .onAppear(perform: viewModel.checkIsAuthorized)
                    }
                    .environment(\.router, router)
                } else {
                    NavigationStack(path: $authRouter.routes) {
                        AuthSelectView()
                            .navigationDestination(for: AnyRoute.self) { route in
                                route.destination
                            }
                            .onAppear(perform: viewModel.checkIsAuthorized)
                    }
                    .environment(\.router, authRouter)
                }
            }
        }
            
        
    }
}

#Preview {
    RootView(container: DefaultDependencyContainer())
}
