//
//  project_angkorlifeTests.swift
//  project-angkorlifeTests
//
//  Created by 유영웅 on 1/18/25.
//

import Testing
import Foundation
@testable import project_angkorlife

struct project_angkorlifeTests {
    @available(iOS 15.0, *)
    
    @Test func testIsUserLoggedIn() async throws {
        let isLoggedIn = UserDefaultsManager.instance.isUserLoggedIn()
        #expect(isLoggedIn == true)
    }
    @Test func testSignIn() async throws {
        let userA = "userA"
        let userB = "userB"
        UserDefaultsManager.instance.signIn(id:userA)
        #expect(userB == UserDefaults.standard.object(forKey:"user_id") as? String)
    }
}
