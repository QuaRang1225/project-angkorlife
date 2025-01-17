//
//  project_angkorlifeTests.swift
//  project-angkorlifeTests
//
//  Created by 유영웅 on 1/18/25.
//

import Testing
@testable import project_angkorlife

struct project_angkorlifeTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
    @available(iOS 15.0, *)
    @Test func testIsUserLoggedIn() async throws {
        let isLoggedIn = UserDefaultsManager.instance.isUserLoggedIn()
        #expect(isLoggedIn == true)
    }
}
