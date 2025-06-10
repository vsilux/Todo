//
//  EmailInputValidatorTests.swift
//  TodoTests_
//
//  Created by Illia Suvorov on 10.06.2025.
//

import XCTest

@testable import Todo

final class EmailInputValidatorTests: XCTestCase {

    func testEmailValidation() throws {
        let sut = EmailInputValidator()
        
        var email = ""
        do {
            try sut.validate(email)
            XCTFail("Expected to throw error for empty email, but it didn't")
        } catch {
            XCTAssertEqual(error as? EmailInputValidator.Error, .emptyEmail, "Expected emptyEmail error")
        }
        
        email = "invalid email"
        do {
            try sut.validate(email)
            XCTFail("Expected to throw error for invalid email format, but it didn't")
        } catch {
            XCTAssertEqual(error as? EmailInputValidator.Error, .invalidEmailFormat, "Expected invalidEmailFormat error")
        }
        
        email = "test@email.com"
        
        do {
            try sut.validate(email)
        } catch {
            XCTFail("Expected no error for valid email, but got \(error)")
        }
    }

}
