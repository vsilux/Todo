//
//  RootView.swift
//  Todo
//
//  Created by Illia Suvorov on 09.06.2025.
//

import Foundation
import SwiftUI

struct RootView: View {
    @StateObject private var router: Router = Router()
    @StateObject private var viewModel: RootViewModel
    
    init() {
        @Environment(\.dependancyContainer) var container
        _viewModel = StateObject(
            wrappedValue: RootViewModel(
                authService: container.authService,
            )
        )
    }
    
    var body: some View {
        NavigationStack(path: $router.routes) {
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
                VStack {
                    if viewModel.user != nil {
                        HomeView()
                    } else {
                        AuthSelectView()
                    }
                }
            }
            .navigationDestination(for: Route.self) { route in
                route.destination
            }
            .onAppear(perform: viewModel.checkIsAuthorized)
        }
        .environment(\.router, router)
        
    }
}

#Preview {
    RootView()
}
