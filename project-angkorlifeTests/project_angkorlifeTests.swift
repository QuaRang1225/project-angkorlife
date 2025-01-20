//
//  project_angkorlifeTests.swift
//  project-angkorlifeTests
//
//  Created by 유영웅 on 1/18/25.
//

import Testing
import SwiftUI
import Foundation
import Combine
import Alamofire
@testable import project_angkorlife

struct project_angkorlifeTests {
    @available(iOS 15.0, *)
    
    
    //ID 매칭 확인 테스트
    @Test func testSignIn() async throws {
        let userA = "userA"
        let userB = "userB"
        UserDefaultsManager.instance.signIn(id:userA)
        #expect(userB == UserDefaults.standard.object(forKey:"user_id") as? String)
    }
    //url 숨김처리 테스트
    @Test func testConfiguration() async throws{
        let api = APIClient.baseURL
        #expect("https://api-wmu-dev.angkorcoms.com" == api)
    }
}
