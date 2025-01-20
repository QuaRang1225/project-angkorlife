//
//  VoteViewModel.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/20/25.
//

import Foundation
import Combine

class VoteViewModel:ObservableObject{
    
    @Published var candidateList:CandidateList? = nil
    @Published var candidate:Candidate? = nil
    @Published var votedCandidateList:[Int] = []
    @Published var userId = UserDefaultsManager.instance.getUserId()
    var error = PassthroughSubject<(String,Bool),Never>()
    var cancel = Set<AnyCancellable>()
    
    func fetchCandidateList(){
        APIService.requset(router: .candidateList)
            .sink { completion in
                ResponseCompletionManager.instance.compltionHandler(message: "투표자 리스트 조회", completion: completion)
            } receiveValue: { (value:CandidateList) in
                self.candidateList = value
            }.store(in: &cancel)
    }
    func fetchCandidate(id:Int,userId:String){
        APIService.requset(router: .candidate(id: id, userId: userId))
            .sink { completion in
                ResponseCompletionManager.instance.compltionHandler(message: "투표자 프로필 조회", completion: completion)
            } receiveValue: { (value:Candidate) in
                self.candidate = value
            }.store(in: &cancel)
    }
    func sendVote(userId:String,id:Int){
        APIService.requset(router: .vote(userId: userId, id: id))
            .sink { completion in
                ResponseCompletionManager.instance.compltionHandler(message: "투표", completion: completion)
            } receiveValue: { value in
                self.error.send((value,!value.isEmpty ? true : false))
                print("눌림\(value) \(!value.isEmpty ? true : false)")
            }.store(in: &cancel)
    }
    func fetchVotedCandidateList(userId:String){
        APIService.requset(router: .votedCandidateList(userId: userId))
            .sink { completion in
                ResponseCompletionManager.instance.compltionHandler(message: "유저 투표 투표자 프로필 조회", completion: completion)
            } receiveValue: { (value:[Int]) in
                self.votedCandidateList = value
            }.store(in: &cancel)
    }
}
