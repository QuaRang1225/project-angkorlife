//
//  APIMonitor.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/20/25.
//

import Foundation
import Alamofire

final class APIMonitor:EventMonitor{
    //만약 요청이 실패했을 떄를 대비해 응답값을 모니터링할 수 있도록 추가
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        print("response message : \(response.description)")
    }
}
