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
    
    func testSuccessLogin() async throws {
        let mockAuthService = MockAuthService(
            signupClosure: { email, password in
                User.dummy
            }
        )
        let sut = DefaultSignupUseCase(authService: mockAuthService)
        
        let user = try await sut.execute(email: "test@email.com", password: "password")
        
        XCTAssertEqual(user.uid, User.dummy.uid, "User should match the dummy user")
    }
    
    func testFailureLogin() async throws {
        let mockAuthService = MockAuthService(
            signupClosure: { _, _ in
                throw AuthServiceError.invalidEmail
            }
        )
        
        let sut = DefaultSignupUseCase(authService: mockAuthService)
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

