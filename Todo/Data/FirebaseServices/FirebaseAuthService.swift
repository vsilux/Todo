//
//  FirebaseAuthService.swift
//  Todo
//
//  Created by Illia Suvorov on 04.06.2025.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class FirebaseAuthService {
    func signup(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
        } catch AuthErrorCode.invalidEmail {
            throw Error.invalidEmail
        } catch AuthErrorCode.weakPassword {
            throw Error.weakPassword
        } catch AuthErrorCode.emailAlreadyInUse {
            throw Error.emailAlreadyInUse
        } catch {
            throw Error.generalError(error)
        }
    }
}

extension FirebaseAuthService {
    enum Error: Swift.Error {
        case invalidEmail
        case weakPassword
        case emailAlreadyInUse
        case generalError(Swift.Error)
    }
}
    
