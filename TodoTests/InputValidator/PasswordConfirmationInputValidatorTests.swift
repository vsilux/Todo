//
//  PasswordConfirmationInputValidatorTests.swift
//  TodoTests_
//
//  Created by Illia Suvorov on 10.06.2025.
//

import XCTest

@testable import Todo

final class PasswordConfirmationInputValidatorTests: XCTestCase {

    func testPasswordConfirmationValidation() throws {
        let password = "goodPassword(2^"
        let sut = PasswordConfirmationInputValidator(password: password)
        
        var passwordConfirmation = ""
        do {
            try sut.validate(passwordConfirmation)
            XCTFail("Expected to throw empty error, but it didn't")
        } catch PasswordConfirmationInputValidator.Error.emptyConfirmation {
            XCTAssertTrue(true, "Expected to throw empty error")
        }
        
        passwordConfirmation = "someMismatchedPassword"
        do {
            try sut.validate(passwordConfirmation)
            XCTFail("Expected to throw mismatch error, but it didn't")
        } catch PasswordConfirmationInputValidator.Error.passwordsDoNotMatch {
            XCTAssertTrue(true, "Expected to throw mismatch error")
        }
        
        passwordConfirmation = password
        do {
            try sut.validate(passwordConfirmation)
        } catch {
            XCTFail("Expected to succeed, but got error: \(error)")
        }
    }

}
