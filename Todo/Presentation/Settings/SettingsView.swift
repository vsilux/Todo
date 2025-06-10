//
//  SettingsView.swift
//  Todo
//
//  Created by Illia Suvorov on 09.06.2025.
//

import SwiftUI
import SimpleRoute

struct SettingsView: View {
    @Environment(\.router) private var router: Router
    
    @StateObject private var viewModel: SettingsViewModel
    
    init(viewModel: SettingsViewModel) {
        _viewModel = StateObject(
            wrappedValue: viewModel
        )
    }
    
    var body: some View {
        Form {
            Section {
                Button(LocalizedKey.Settings.logoutButtonTitle.localized) {
                    viewModel.logout {
                        router.popToRoot()
                    }
                }
            }
        }
        .navigationTitle(LocalizedKey.Settings.title.localized)
    }
}

#Preview {
    SettingsView(
        viewModel: SettingsViewModel(authService: MockAuthService())
    )
}
