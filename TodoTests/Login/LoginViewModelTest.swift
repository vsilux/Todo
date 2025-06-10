//
//  LoginViewModelTest.swift
//  TodoTests_
//
//  Created by Illia Suvorov on 10.06.2025.
//

import XCTest

@testable import Todo

final class LoginViewModelTest: XCTestCase {

    func testErrorMessageRemovalOnTextChanged() async throws {
        let sut = createSUT()
        let errorMessage = "test error message"
        
        sut.email.errorMessageKey = errorMessage
        sut.password.errorMessageKey = errorMessage
        
        sut.email.value = "new email"
        XCTAssertNil(sut.email.errorMessageKey, "Email error message should be removed on text change")
        
        sut.password.value = "new password"
        XCTAssertNil(sut.password.errorMessageKey, "Password error message should be removed on text change")
    }
    
    func testFocusChangeTriggersValidation() async throws {
        let sut = createSUT()
        
        sut.email.value = "wrong email format"
        sut.focus = .password
        
        XCTAssertEqual(
            sut.email.errorMessageKey,
            LocalizedKey.Error.invalidEmail
        )
        
        sut.password.value = ""
        sut.focus = .email
        
        XCTAssertEqual(
            sut.password.errorMessageKey,
            LocalizedKey.Error.emptyPassword
        )
    }

    // MARK: - Helper Methods
    
    private func createSUT(authService: AuthService = MockAuthService()) -> LoginViewModel {
        LoginViewModel(loginUseCase: DefaultLoginUseCase(authService: authService, userStore: DefaultUserStore()))
    }
    
}
