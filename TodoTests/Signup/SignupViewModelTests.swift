//
//  SignupViewModelTests.swift
//  TodoTests
//
//  Created by Illia Suvorov on 06.06.2025.
//

import XCTest
import Combine

@testable import Todo

final class SignupViewModelTests: XCTestCase {

    var cancellables: Set<AnyCancellable> = []
    
    func testErrorMessageRemovalOnTextChanged() async throws {
        let sut = createSUT()
        
        sut.email.errorMessageKey = "test.error"
        sut.password.errorMessageKey = "test.error"
        sut.passwordConfirmation.errorMessageKey = "test.error"
        
        sut.email.value = "new email"
        sut.password.value = "new password"
        sut.passwordConfirmation.value = "new password confirmation"
        
        XCTAssertEqual(sut.email.errorMessageKey, nil)
        XCTAssertEqual(sut.password.errorMessageKey, nil)
        XCTAssertEqual(sut.passwordConfirmation.errorMessageKey, nil)
    }
    
    
    func testFocusChangeTriggersValidation() async throws {
        let sut = createSUT()
        
        sut.email.value = "wrong email format"
        sut.focus = .password
        
        XCTAssertEqual(
            sut.email.errorMessageKey,
            LocalizedKey.Error.invalidEmail
        )
        
        sut.password.value = "short"
        sut.focus = .confirmPassword
        
        XCTAssertEqual(
            sut.password.errorMessageKey,
            LocalizedKey.Error.weakPassword
        )
        
        sut.passwordConfirmation.value = "mismatched password"
        sut.focus = .email
        
        XCTAssertEqual(
            sut.passwordConfirmation.errorMessageKey,
            LocalizedKey.Error.passwordConfirmationMismatch
        )
    }

    func testEmailValidation() async throws {
        let sut = createSUT()
        
        sut.email.value = ""
        sut.validateEmail()
        
        XCTAssertEqual(
            sut.email.errorMessageKey,
            LocalizedKey.Error.emailEmpty
        )
        
        sut.email.value = "invalid email"
        sut.validateEmail()
        
        XCTAssertEqual(
            sut.email.errorMessageKey,
            LocalizedKey.Error.invalidEmail
        )
        
        sut.email.value = "test@email.com"
        sut.validateEmail()
        
        XCTAssertEqual(sut.email.errorMessageKey, nil)
    }

    func testPasswordValidation() async throws {
        let sut = createSUT()
        
        sut.password.value = ""
        sut.validatePassword()
        
        XCTAssertEqual(
            sut.password.errorMessageKey,
            LocalizedKey.Error.emptyPassword
        )
        
        sut.password.value = "12345"
        sut.validatePassword()
        
        XCTAssertEqual(
            sut.password.errorMessageKey,
            LocalizedKey.Error.weakPassword
        )
        
        sut.password.value = "strongpassword"
        sut.validatePassword()
        
        XCTAssertEqual(sut.password.errorMessageKey, nil)
    }
    
    func testPasswordConfirmationValidation() async throws {
        let sut = createSUT()
        
        sut.passwordConfirmation.value = ""
        sut.validatePasswordConfirmation()
        
        XCTAssertEqual(
            sut.passwordConfirmation.errorMessageKey,
            LocalizedKey.Error.emptyPasswordConfirmation
        )
        
        sut.password.value = "password"
        sut.passwordConfirmation.value = "different password"
        sut.validatePasswordConfirmation()
        
        XCTAssertEqual(
            sut.passwordConfirmation.errorMessageKey,
            LocalizedKey.Error.passwordConfirmationMismatch
        )
        
        sut.passwordConfirmation.value = "password"
        sut.validatePasswordConfirmation()
        
        XCTAssertEqual(sut.passwordConfirmation.errorMessageKey, nil)
    }
    
    func testEmailAlreadyInUseError() throws {
        let sut = createSUT(authService: MockAuthService(signupClosure: { email, password in
            throw AuthServiceError.emailAlreadyInUse
        }))
        
        sut.email.value = "test@email.com"
        sut.password.value = "password"
        sut.passwordConfirmation.value = "password"
        
        let expectation = XCTestExpectation(
            description: "Email already in use error"
        )
        sut.email.$errorMessageKey.sink { messageKey in
            if messageKey == LocalizedKey.Error.emailAlreadyInUse {
                expectation.fulfill()
            }
        }.store(in: &cancellables)
       
        Task {
            await sut.signup()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: - Helper Methods
    
    private func createSUT(authService: AuthService = MockAuthService()) -> SignupViewModel {
        SignupViewModel(signupUseCase: DefaultSignupUseCase(authService: authService))
    }
}
