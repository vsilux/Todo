//
//  HomeView.swift
//  Todo
//
//  Created by Illia Suvorov on 09.06.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @Environment(\.router) private var router: Router
    
    init() {
        @Environment(\.dependancyContainer) var container
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
                    router.navigate(to: .settings)
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
        HomeView()
    }
}
