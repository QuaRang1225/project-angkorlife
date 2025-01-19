//
//  APIClient.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/20/25.
//

import Foundation
import Alamofire

final class ApiClient{
    
//    var session:Session
    static let shared = ApiClient()
    static let baseURL =  "\(Bundle.main.infoDictionary?["BASE_URL"] ?? "")"
    
//    let monitors = [ApiLogger()] as [EventMonitor]
    
    init(){
//        session = Session(eventMonitors: monitors)
    }
    
}
