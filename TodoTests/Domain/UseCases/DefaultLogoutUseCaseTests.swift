//
//  DefaultLogoutUseCaseTests.swift
//  TodoTests_
//
//  Created by Illia Suvorov on 10.06.2025.
//

import XCTest

@testable import Todo

final class DefaultLogoutUseCaseTests: XCTestCase {

    func testLogout() async throws {
        let userStore = DefaultUserStore()
        userStore.store(.dummy)
        let sut = DefaultLogoutUseCase(
            authService: MockAuthService(),
            userStore: userStore
        )
        
        try await sut.execute()
        
        XCTAssertNil(userStore.currentUser, "User should be nil after logout")
    }

}
