//
//  InitialScreen.swift
//  Todo
//
//  Created by Illia Suvorov on 08.06.2025.
//

import SwiftUI
import SimpleRoute
import Combine

struct AuthView: View {
    @StateObject private var viewModel: AuthViewModel
    @Environment(\.router) private var router
    
    init(viewModel: AuthViewModel) {
        _viewModel = StateObject(
            wrappedValue: viewModel
        )
    }
        
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Text(LocalizedKey.Auth.message.localized)
                .font(.system(size: 32))
                .padding()
                    
            Spacer()
                
            Button {
                viewModel.onLoginTapped { route in
                    router.navigate(to: route)
                }
            } label: {
                Text(LocalizedKey.Login.title.localized)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .frame(height: Constants.textFieldHeight)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(.mint)
            )
            .padding()
                
            Button {
                viewModel.onSignupTapped { route in
                    router.navigate(to: route)
                }
            } label: {
                Text(LocalizedKey.Signup.title.localized)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .frame(height: Constants.textFieldHeight)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(.mint)
            )
            .padding(.horizontal, 16)
            .safeAreaPadding(.bottom, 40)
        }
    }
}

#Preview {
    AuthView(viewModel: AuthViewModel(authService: MockAuthService()))
}
