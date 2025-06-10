//
//  LocalizedKey.swift
//  Todo
//
//  Created by Illia Suvorov on 06.06.2025.
//

import Foundation
import SwiftUICore

enum LocalizedKey {
    enum Signup {
        static let title = "signup.title"
        static let email = "email.placeholder"
        static let password = "password.placeholder"
        static let passwordConfirmation = "password.confirmation.placeholder"
        static let signupButtonTitle = "signup.button.title"
    }
    
    enum Login {
        static let title = "login.title"
        static let email = "email.placeholder"
        static let password = "password.placeholder"
        static let loginButtonTitle = "login.button.title"
    }
    
    enum Auth {
        static let message = "auth.message"
    }
    
    enum Settings {
        static let title = "settings.title"
        static let logoutButtonTitle = "logout.button.title"
    }
    
    enum Error {
        static let somethingWentWrong = "error.somthingWentWrong.message"
        static let operationNotAllowed = "login.operationNotAllowed.message"
        static let userDisabled = "login.userDisabled.message"
        static let wrongPassword = "login.wrongPassword.message"
        static let emailEmpty = "signup.email.empty"
        static let invalidEmail = "signup.email.invalid"
        static let emailAlreadyInUse = "signup.email.alreadyInUse"
        static let emptyPassword = "signup.password.empty"
        static let weakPassword = "signup.password.weak"
        static let emptyPasswordConfirmation = "signup.passwordConfirmation.empty"
        static let passwordConfirmationMismatch = "signup.passwordConfirmation.mismatch"
    }
}

extension String {
    var localized: LocalizedStringKey {
        return LocalizedStringKey(self)
    }
}

