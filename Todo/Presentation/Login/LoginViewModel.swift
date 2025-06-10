//
//  LoginViewModel.swift
//  Todo
//
//  Created by Illia Suvorov on 05.06.2025.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var email = ValidatedInputField()
    @Published var password = ValidatedInputField()
    @Published var errorMessageKey: String?
    @Published var isLoading: Bool = false
    @Published var focus: Focus? = .email
    
    private var subscriptions = Set<AnyCancellable>()
    
    let loginUseCase: LoginUseCase
    
    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
        email.setupErrorClearingOnValueEditing()
        password.setupErrorClearingOnValueEditing()
        $focus.sink { newFocus in
            if self.focus != newFocus {
                switch self.focus {
                case .email:
                    self.validateEmail()
                case .password:
                    self.validatePassword()
                case .none:
                    return
                }
            }
        }.store(in: &subscriptions)
    }
    
    func login(completion: @escaping () -> Void) {
        isLoading = true
        Task {
            do {
                _ = try await loginUseCase.execute(email: email.value, password: password.value)
            } catch AuthServiceError.operationNotAllowed {
                await updateErrorMessageKey(LocalizedKey.Error.operationNotAllowed)
            } catch AuthServiceError.userDisabled {
                await updateErrorMessageKey(LocalizedKey.Error.userDisabled)
            } catch AuthServiceError.wrongPassword {
                password.errorMessageKey = LocalizedKey.Error.wrongPassword
            } catch {
                print(error)
                await updateErrorMessageKey("login.somthingWentWrong.message")
            }
            
            await MainActor.run {
                completion()
                isLoading = false
            }
        }
    }
    
    func validateEmail() {
        do {
            try EmailInputValidator().validate(email.value)
        } catch EmailInputValidator.Error.emptyEmail {
            email.errorMessageKey = LocalizedKey.Error.emailEmpty
        } catch EmailInputValidator.Error.invalidEmailFormat {
            email.errorMessageKey = LocalizedKey.Error.invalidEmail
        } catch {
            email.errorMessageKey = LocalizedKey.Error.somethingWentWrong
        }
    }
    
    func validatePassword() {
        if password.value.isEmpty {
            password.errorMessageKey = LocalizedKey.Error.emptyPassword
        }
    }
    
    @MainActor
    private func updateErrorMessageKey(_ key: String) async {
        errorMessageKey = key
    }
}

extension LoginViewModel {
    enum Focus {
        case email
        case password
    }
}

