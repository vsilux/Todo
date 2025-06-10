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
        sut.email.value = "test@email.com"
        sut.password.value = "password"
        
    }
    
//    func testErrorMessageRemovalOnTextChanged() async throws {
//        let sut = createSUT()
//        
//        sut.email.errorMessageKey = "test.error"
//        sut.password.errorMessageKey = "test.error"
//        sut.passwordConfirmation.errorMessageKey = "test.error"
//        
//        sut.email.value = "new email"
//        sut.password.value = "new password"
//        sut.passwordConfirmation.value = "new password confirmation"
//        
//        XCTAssertEqual(sut.email.errorMessageKey, nil)
//        XCTAssertEqual(sut.password.errorMessageKey, nil)
//        XCTAssertEqual(sut.passwordConfirmation.errorMessageKey, nil)
//    }

    
    private func createSUT(authService: AuthService = MockAuthService()) -> LoginViewModel {
        LoginViewModel(loginUseCase: DefaultLoginUseCase(authService: authService))
    }
    
}
