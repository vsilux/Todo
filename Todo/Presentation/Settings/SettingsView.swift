//
//  SettingsView.swift
//  Todo
//
//  Created by Illia Suvorov on 09.06.2025.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.router) private var router: Router
    @StateObject private var viewModel: SettingsViewModel
    
    init() {
        @Environment(\.dependancyContainer) var container
        _viewModel = StateObject(
            wrappedValue: SettingsViewModel(
                logoutUseCase: container.logoutUseCase
            )
        )
    }
    
    var body: some View {
        Form {
            Section {
                Button(LocalizedKey.Settings.logoutButtonTitle.localized) {
                    viewModel.logout {
                        router.navigateBackToRoot()
                    }
                }
            }
        }
        .navigationTitle(LocalizedKey.Settings.title.localized)
    }
}

#Preview {
    SettingsView()
}
