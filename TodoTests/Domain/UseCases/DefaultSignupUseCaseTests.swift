//
//  SignupUseCaseTests.swift
//  Todo
//
//  Created by Illia Suvorov on 10.06.2025.
//

import XCTest
import Combine

@testable import Todo

final class DefaultSignupUseCaseTests: XCTestCase {
    
    func testSuccessSigup() async throws {
        let userStore = DefaultUserStore()
        let mockAuthService = MockAuthService(
            signupClosure: { email, password in
                User.dummy
            }
        )
        let sut = DefaultSignupUseCase(authService: mockAuthService, userStore: userStore)
        
        try await sut.execute(email: "test@email.com", password: "password")
        
        XCTAssertEqual(userStore.currentUser?.uid, User.dummy.uid, "User should match the dummy user")
    }
    
    func testFailureSignup() async throws {
        let mockAuthService = MockAuthService(
            signupClosure: { _, _ in
                throw AuthServiceError.invalidEmail
            }
        )
        
        let sut = DefaultSignupUseCase(authService: mockAuthService, userStore: DefaultUserStore())
        do {
            _ = try await sut.execute(email: "email", password: "password")
            XCTFail("Expected to throw invalidEmail error, but it didn't")
        } catch AuthServiceError.invalidEmail {
            XCTAssertTrue(true, "Expected invalidEmail error")
        } catch {
            XCTFail("Expected invalidEmail error, but got \(error)")
        }
    }
        
}

