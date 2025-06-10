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
    @StateObject private var router: Router = Router()
    @StateObject private var viewModel: RootViewModel
    
    init(viewModel: RootViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
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
                        HomeView(viewModel: viewModel.getHomeViewModel())
                    } else {
                        AuthView(
                            viewModel: viewModel.getAuthViewModel()
                        )
                    }
                }
            }
            .navigationDestination(for: AnyRoute.self) { route in
                route.destination
            }
            .onAppear(perform: viewModel.checkIsAuthorized)
        }
        .environment(\.router, router)
        
    }
}

#Preview {
    RootView(
        viewModel: RootViewModel(
            authService: MockAuthService(),
        )
    )
}
