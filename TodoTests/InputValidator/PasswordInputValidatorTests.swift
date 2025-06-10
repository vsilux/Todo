//
//  PasswordInputValidatorTests.swift
//  TodoTests_
//
//  Created by Illia Suvorov on 10.06.2025.
//

import XCTest

@testable import Todo

final class PasswordInputValidatorTests: XCTestCase {

    func testPasswordValidation() throws {
        let sut = PasswordInputValidator()
        
        var password = ""
        do {
            try sut.validate(password)
            XCTFail("Expected to throw empty error, but it didn't")
        } catch PasswordInputValidator.Error.emptyPassword {
            XCTAssertTrue(true, "Expected empty password error")
        }
        
        password = "short"
        do {
            try sut.validate(password)
            XCTFail("Expected to throw weak password error, but it didn't")
        } catch PasswordInputValidator.Error.weakPassword {
            XCTAssertTrue(true, "Expected weak password error")
        }
        
        password = "validPassword123"
        do {
            try sut.validate(password)
        } catch {
            XCTFail("Expected no error, but got \(error)")
        }
    }
}
