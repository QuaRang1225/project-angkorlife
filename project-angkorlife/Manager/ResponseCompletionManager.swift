//
//  ResponseCompletionManager.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/20/25.
//

import Foundation
import Alamofire
import Combine

class ResponseCompletionManager{
    static let instance = ResponseCompletionManager()
    private init(){}
    
    func compltionHandler(message:String,completion:Subscribers.Completion<AFError>){
        switch completion {
        case .finished:
            print("\(message) API 호출 성공")
        case .failure(let error):
            print("\(message) API 호출 실패: \(error.localizedDescription)")
        }
    }
}
