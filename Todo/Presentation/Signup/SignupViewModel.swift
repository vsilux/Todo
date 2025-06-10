//
//  SignupViewModel.swift
//  Todo
//
//  Created by Illia Suvorov on 05.06.2025.
//

import Foundation
import Combine

class SignupViewModel: ObservableObject {
    @Published var email = ValidatedInputField()
    @Published var password = ValidatedInputField()
    @Published var passwordConfirmation = ValidatedInputField()
    @Published var focus: Focus? = .email
    @Published var isLoading: Bool = false
    private var subscriptions = Set<AnyCancellable>()
    private let sigupUseCase: SignupUseCase
    
    init(sigupUseCase: SignupUseCase) {
        self.sigupUseCase = sigupUseCase
        email.setupErrorClearingOnValueEditing()
        password.setupErrorClearingOnValueEditing()
        passwordConfirmation.setupErrorClearingOnValueEditing()
        $focus.sink { newFocus in
            if self.focus != newFocus {
                switch self.focus {
                case .email:
                    self.validateEmail()
                case .password:
                    self.validatePassword()
                case .confirmPassword:
                    self.validatePasswordConfirmation()
                case .none:
                    return
                }
            }
        }.store(in: &subscriptions)
    }
    
    func signup() async {
        validateAll()
        if email.errorMessageKey == nil &&
            password.errorMessageKey == nil &&
            passwordConfirmation.errorMessageKey == nil {
            await MainActor.run {
                isLoading = true
            }
            Task {
                do {
                    _ = try await sigupUseCase.execute(
                        email: email.value,
                        password: password.value
                    )
                } catch AuthServiceError.emailAlreadyInUse {
                    email.errorMessageKey = LocalizedKey.Error.emailAlreadyInUse
                } catch {
                    print(error)
                }
                
                await MainActor.run {
                    isLoading = false
                }
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
        do {
            try PasswordInputValidator().validate(password.value)
        } catch PasswordInputValidator.Error.emptyPassword {
            password.errorMessageKey = LocalizedKey.Error.emptyPassword
        } catch PasswordInputValidator.Error.weakPassword {
            password.errorMessageKey = LocalizedKey.Error.weakPassword
        } catch {
            password.errorMessageKey = LocalizedKey.Error.somethingWentWrong
        }
    }

    func validatePasswordConfirmation() {
        do {
            try PasswordConfirmationInputValidator(password: password.value).validate(passwordConfirmation.value)
        } catch PasswordConfirmationInputValidator.Error.emptyConfirmation {
            passwordConfirmation.errorMessageKey = LocalizedKey.Error.emptyPasswordConfirmation
        } catch PasswordConfirmationInputValidator.Error.passwordsDoNotMatch {
            passwordConfirmation.errorMessageKey = LocalizedKey.Error.passwordConfirmationMismatch
        } catch {
            passwordConfirmation.errorMessageKey = LocalizedKey.Error.somethingWentWrong
        }
    }
    
    func validateAll() {
        validateEmail()
        validatePassword()
        validatePasswordConfirmation()
    }
}

extension SignupViewModel {
    enum Focus: Hashable {
        case email
        case password
        case confirmPassword
    }
}
