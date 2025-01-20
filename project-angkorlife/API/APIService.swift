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
    static func requset(router:APIRouter)-> AnyPublisher<String,AFError>{
        return APIClient.shared.session
            .request(router)
            .validate(statusCode: 200..<300)
            .publishString()
            .tryMap { response -> String in
                guard let code = response.response?.statusCode else { return "" }
                switch code {
                case 200..<300: guard let value = response.value, value.isEmpty else{ return "" }; return value
                default:
                    guard let data = response.data else { return "" }
                    let error = try JSONDecoder().decode(ErrorMessage.self, from: data)
                    return error.errorMessage
                }
            }
            .mapError { $0.asAFError ?? AFError.explicitlyCancelled }
            .eraseToAnyPublisher()
    }
}
