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
    
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(
            wrappedValue: viewModel
        )
    }
    
    var body: some View {
        VStack {
            Text("User name: \(viewModel.user.displayName ?? "Unknown")")
                .navigationTitle("Home")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.onSettingsTapped { route in
                        router.navigate(to: route)
                    }
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
        HomeView(viewModel: HomeViewModel(user: .dummy))
    }
}
