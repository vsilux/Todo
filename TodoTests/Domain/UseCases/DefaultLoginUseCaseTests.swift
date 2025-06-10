//
//  DefaultLoginUseCaseTests.swift
//  TodoTests_
//
//  Created by Illia Suvorov on 10.06.2025.
//

import XCTest

@testable import Todo

final class DefaultLoginUseCaseTests: XCTestCase {

    func testSuccessLogin() async throws {
        let userStore = DefaultUserStore()
        let mockAuthService = MockAuthService(
            loginClosure: { email, password in
                User.dummy
            }
        )
        let sut = DefaultLoginUseCase(authService: mockAuthService, userStore: userStore)
        
        try await sut.execute(email: "test@email.com", password: "password")
        
        XCTAssertEqual(userStore.currentUser?.uid, User.dummy.uid, "User should match the dummy user")
    }
    
    func testFailureLogin() async throws {
        let mockAuthService = MockAuthService(
            loginClosure: { _, _ in
                throw AuthServiceError.wrongPassword
            }
        )
        
        let sut = DefaultLoginUseCase(authService: mockAuthService, userStore: DefaultUserStore())
        do {
            _ = try await sut.execute(email: "email", password: "password")
            XCTFail("Expected to throw wrongPassword error, but it didn't")
        } catch AuthServiceError.wrongPassword {
            XCTAssertTrue(true, "Expected wrongPassword error")
        } catch {
            XCTFail("Expected wrongPassword error, but got \(error)")
        }
    }

}
