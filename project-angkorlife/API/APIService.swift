//
//  APIService.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/20/25.
//

import Foundation
import Alamofire
import Combine

class APIService{
    static func requset<T:Codable>(router:APIRouter)-> AnyPublisher<T,AFError>{
        return APIClient.shared.session
            .request(router)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: T.self)
            .value()
            .eraseToAnyPublisher()
    }
}
