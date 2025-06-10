//
//  SignupView.swift
//  Todo
//
//  Created by Illia Suvorov on 05.06.2025.
//

import Foundation
import SwiftUI

struct SignupView: View {
    private let textFieldBottomPadding: CGFloat = 10
    private let buttonTopPadding: CGFloat = 40
    @StateObject private var viewModel: SignupViewModel
    @FocusState private var signupInFocus: SignupViewModel.Focus?
    
    init(viewModel: SignupViewModel) {
        _viewModel = StateObject(
            wrappedValue: viewModel
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
                    onCommit: {
                        viewModel.focus = .confirmPassword
                    }
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

            ZStack {
                SecureField(
                    LocalizedKey.Signup.passwordConfirmation.localized,
                    text: $viewModel.passwordConfirmation.value
                )
                .textContentType(.none)
                .frame(height: Constants.textFieldHeight)
                .modifier(TextInputModifier())
                .focused($signupInFocus, equals: .confirmPassword)
                
                ErrorMessageButton(
                    errorMessageKey: $viewModel.passwordConfirmation.errorMessageKey
                )
                .padding(.trailing, Constants.textFieldErrorButtonTrailingPadding)
            }
            
            ZStack {
                Button {
                    Task {
                        await viewModel.signup()
                    }
                } label: {
                    Text(LocalizedKey.Signup.signupButtonTitle.localized)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                .frame(height: Constants.textFieldHeight)
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.mint)
                )
                .opacity(viewModel.isLoading ? 0.0 : 1)
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .frame(
                            maxHeight: Constants.textFieldHeight,
                            alignment: .center
                        )
                }
            }
            .padding(.top, buttonTopPadding)
        }
        .padding()
        .navigationTitle(LocalizedKey.Signup.title.localized)
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: signupInFocus) { _, newValue in
            viewModel.focus = newValue
        }.onChange(of: viewModel.focus) { _, newValue in
            signupInFocus = newValue
        }
    }
}

extension SignupView {
    enum SignupFocusable: Hashable {
        case email
        case password
        case confirmPassword
    }
}

#Preview {
    NavigationStack {
        SignupView(
            viewModel: SignupViewModel(
                sigupUseCase: DefaultSignupUseCase(
                    authService: MockAuthService(
                        signupClosure: { _, _ in
                            throw AuthServiceError.invalidEmail
                        })
                )
            )
        )
    }
}
