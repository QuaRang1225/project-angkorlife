//
//  APIClient.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/20/25.
//

import Foundation
import Alamofire

final class ApiClient{
    
    var session:Session
    static let shared = ApiClient()
    static let baseURL =  "\(Bundle.main.infoDictionary?["BASE_URL"] ?? "")"    //baseURL 설정
    
    let monitors = [APIMonitor()] as [EventMonitor]                             //이벤트 모니터 추가
    
    private init(){
        session = Session(eventMonitors: monitors)
    }
    
}
