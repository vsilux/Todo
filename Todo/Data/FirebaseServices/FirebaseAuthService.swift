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

protocol AuthService {
    var user: User? { get }
    
    func login(email: String, password: String) async throws -> User
    func signup(email: String, password: String) async throws -> User
    func logout() async
}

enum AuthServiceError: Swift.Error {
    case invalidEmail
    case weakPassword
    case emailAlreadyInUse
    case passwordTooShort
    case operationNotAllowed
    case userDisabled
    case wrongPassword
    case general(Swift.Error)
}

class FirebaseAuthService: AuthService {
    var user: User? {
        if let currentUser = Auth.auth().currentUser {
            return .from(firebaseUser: currentUser)
        }
        
        return nil
    }
    
    func login(email: String, password: String) async throws -> User {
        do {
            let result = try await Auth.auth().signIn(
                withEmail: email,
                password: password
            )
            return .from(firebaseUser: result.user)
        } catch let error as NSError where error.code == AuthErrorCode.operationNotAllowed.rawValue {
            throw AuthServiceError.operationNotAllowed
        } catch let error as NSError where error.code == AuthErrorCode.userDisabled.rawValue {
            throw AuthServiceError.userDisabled
        } catch let error as NSError where error.code == AuthErrorCode.wrongPassword.rawValue {
            throw AuthServiceError.wrongPassword
        } catch let error as NSError where error.code == AuthErrorCode.invalidEmail.rawValue {
            throw AuthServiceError.invalidEmail
        } catch {
            throw AuthServiceError.general(error)
        }
    }
    
    func signup(email: String, password: String) async throws -> User {
        do {
            let result = try await Auth.auth().createUser(
                withEmail: email,
                password: password
            )
            return .from(firebaseUser: result.user)
        } catch let error as NSError where error.code == AuthErrorCode.invalidEmail.rawValue {
            throw AuthServiceError.invalidEmail
        } catch let error as NSError where error.code == AuthErrorCode.weakPassword.rawValue {
            throw AuthServiceError.weakPassword
        } catch let error as NSError where error.code == AuthErrorCode.emailAlreadyInUse.rawValue {
            throw AuthServiceError.emailAlreadyInUse
        }  catch {
            throw AuthServiceError.general(error)
        }
    }
    
    func logout() async {
        try? Auth.auth().signOut()
    }
}
    
extension User {
    static func from(firebaseUser: FirebaseAuth.User) -> User {
        User(
            uid: firebaseUser.uid,
            displayName: firebaseUser.displayName,
            photoURL: firebaseUser.photoURL,
            email: firebaseUser.email,
            phoneNumber: firebaseUser.phoneNumber
        )
    }
}
