//
//  HomeView.swift
//  Todo
//
//  Created by Illia Suvorov on 09.06.2025.
//

import SwiftUI
import SimpleRoute

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @Environment(\.router) private var router: Router
    @Environment(\.dependancyContainer) var container
    
    init(container: DependencyContainer) {
        _viewModel = StateObject(
            wrappedValue: HomeViewModel(
                userStore: container.userStore
            )
        )
    }
    
    var body: some View {
        VStack {
            Text("User name: Unknown")
                .navigationTitle("Home")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    router.navigate(to: SettingsRoute(dependencyContainer: container))
                } label: {
                    Image(systemName: "gear")
                        .foregroundColor(.primary)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView(container: DefaultDependencyContainer())
    }
}
