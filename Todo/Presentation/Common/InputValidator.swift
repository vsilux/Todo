//
//  InputValidator.swift
//  Todo
//
//  Created by Illia Suvorov on 10.06.2025.
//

import Foundation

protocol InputValidator {
    func validate(_ input: String) throws
}

struct EmailInputValidator: InputValidator {
    enum Error: Swift.Error {
        case invalidEmailFormat
        case emptyEmail
    }
    
    func validate(_ input: String) throws {
        guard !input.isEmpty else {
            throw Error.emptyEmail
        }
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
            
        if !emailPredicate.evaluate(with: input) {
            throw Error.invalidEmailFormat
        }
    }
}

struct PasswordInputValidator: InputValidator {
    enum Error: Swift.Error {
        case emptyPassword
        case weakPassword
    }
    
    func validate(_ input: String) throws {
        guard !input.isEmpty else {
            throw Error.emptyPassword
        }
        
        if input.count < 6 {
            throw Error.weakPassword
        }
    }
}

struct PasswordConfirmationInputValidator: InputValidator {
    enum Error: Swift.Error {
        case emptyConfirmation
        case passwordsDoNotMatch
    }
    
    let password: String
    
    func validate(_ input: String) throws {
        guard !input.isEmpty else {
            throw Error.emptyConfirmation
        }
        
        if input != password {
            throw Error.passwordsDoNotMatch
        }
    }
}
