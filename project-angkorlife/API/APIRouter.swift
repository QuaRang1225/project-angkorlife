//
//  APIRouter.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/20/25.
//

import Foundation
import Alamofire

enum APIRouter:URLRequestConvertible{
    case candidateList
    case candidate(id:Int,userId:String)
    case vote(userId:String,id:Int)
    case votedCandidateList(userId:String)
    
    var baseUrl:URL{
        return URL(string:APIClient.baseURL)!
    }
    var endPoint:String{
        switch self{
        case .candidateList: "/vote/candidate/list"
        case let .candidate(id,_): "/vote/candidate/\(id)"
        case .vote: "/vote"
        case .votedCandidateList: "/vote/voted/candidate/list"
        }
    }
    var method:HTTPMethod{
        switch self{
        case .candidateList,.candidate,.votedCandidateList: .get
        case .vote: .post
        }
    }
    var parameters:Parameters{
        switch self{
        case .candidateList: return Parameters()
        case let .candidate(_,userId):
            var param = Parameters()
            param["userId"] = userId
            return param
        case let .vote(userId,id):
            var param = Parameters()
            param["userId"] = userId
            param["id"] = id
            return param
        case let .votedCandidateList(userId):
            var param = Parameters()
            param["userId"] = userId
            return param
        }
    }
    func asURLRequest() throws -> URLRequest {
            let url = baseUrl.appendingPathComponent(endPoint)
            var request = URLRequest(url: url)
            request.method = method
            switch self{
            case .vote:
                return try URLEncoding(destination: .httpBody).encode(request, with: parameters)    //body
            case .candidate,.votedCandidateList:
                return try URLEncoding(destination: .queryString).encode(request, with: parameters) //query string
            case .candidateList:                                                                    //no param
                return request
            }
        }
}

