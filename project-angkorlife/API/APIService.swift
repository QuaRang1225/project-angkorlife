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
    //별다른 특이사항이 없는 요청의 경우 이 메서드를 호출
    static func requset<T:Codable>(router:APIRouter)-> AnyPublisher<T,AFError>{
        return APIClient.shared.session
            .request(router)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: T.self)
            .value()
            .eraseToAnyPublisher()
    }
    //투표 요청의 경우, 성공과 실패가 서로 응답 데이터가 다름
    //각각의 응답 차이를 고려해 데이터를 변환해서 각각의 상황에 맞워서 사용하기 위해 request메서드 하나 더 생성
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
