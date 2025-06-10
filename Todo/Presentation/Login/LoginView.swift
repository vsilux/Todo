//
//  LoginView.swift
//  Todo
//
//  Created by Illia Suvorov on 04.06.2025.
//

import SwiftUI
import SimpleRoute

struct LoginView: View {
    private let textFieldBottomPadding: CGFloat = 10
    
    @StateObject private var viewModel: LoginViewModel
    @Environment(\.router) private var router
    @FocusState private var signupInFocus: LoginViewModel.Focus?
    
    init() {
        @Environment(\.dependancyContainer) var container
        _viewModel = StateObject(
            wrappedValue: LoginViewModel(
                loginUseCase: container.loginUseCase
            )
        )
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                TextField(
                    LocalizedKey.Signup.email.localized,
                    text: $viewModel.email.value,
                    onCommit: {
                        viewModel.focus = .password
                    })
                .submitLabel(.next)
                .frame(height: Constants.textFieldHeight)
                .modifier(TextInputModifier())
                .autocorrectionDisabled()
                .autocapitalization(.none)
                .focused($signupInFocus, equals: .email)
                
                ErrorMessageButton(
                    errorMessageKey: $viewModel.email.errorMessageKey
                )
                .padding(.trailing, Constants.textFieldErrorButtonTrailingPadding)
            }
            .padding(.bottom, textFieldBottomPadding)
            
            ZStack {
                SecureField(
                    LocalizedKey.Signup.password.localized,
                    text: $viewModel.password.value,
                )
                .submitLabel(.next)
                .textContentType(.none)
                .frame(height: Constants.textFieldHeight)
                .modifier(TextInputModifier())
                .focused($signupInFocus, equals: .password)
                    
                ErrorMessageButton(
                    errorMessageKey: $viewModel.password.errorMessageKey
                )
                .padding(.trailing, Constants.textFieldErrorButtonTrailingPadding)
            }
            .padding(.bottom, textFieldBottomPadding)
            
            VStack(alignment: .leading) {
                if let errorMessageKey = viewModel.errorMessageKey {
                    Text(LocalizedStringKey(errorMessageKey))
                        .font(.caption)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .padding(.bottom, 4)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 32)
            
            Button {
                viewModel.login {
                    router.pop()
                }
            } label: {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.white)
                        .frame(maxWidth: .infinity)
                } else {
                    Text(LocalizedKey.Login.loginButtonTitle.localized)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
            }
            .frame(height: Constants.textFieldHeight)
            .foregroundColor(.white)
            .disabled(viewModel.isLoading)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(.mint)
            )
                
        }
        .padding()
        .navigationTitle(LocalizedKey.Login.title.localized)
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: signupInFocus) { _, newValue in
            viewModel.focus = newValue
        }.onChange(of: viewModel.focus) { _, newValue in
            signupInFocus = newValue
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
