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
                switch completion {
                case .finished:
                    print("투표자 리스트 조회 API 호출 성공")
                case .failure(let error):
                    print("투표자 리스트 조회 API 호출 실패: \(error.localizedDescription)")
                }
            } receiveValue: { (value:CandidateList) in
                self.candidateList = value
            }.store(in: &cancel)
    }
    func fetchCandidate(id:Int,userId:String){
        APIService.requset(router: .candidate(id: id, userId: userId))
            .sink { completion in
                switch completion {
                case .finished:
                    print("투표자 프로필 조회 API 호출 성공")
                case .failure(let error):
                    print("투표자 프로필 조회 API 호출 실패: \(error.localizedDescription)")
                }
            } receiveValue: { (value:Candidate) in
                self.candidate = value
            }.store(in: &cancel)
    }
    func sendVote(userId:String,id:Int){
        APIService.requset(router: .vote(userId: userId, id: id))
            .sink { completion in
                switch completion {
                case .finished:
                    print("투표 API 호출 성공 \(completion)")
                case .failure(let error):
                    print("투표 API 호출 실패: \(error.localizedDescription)")
                }
            } receiveValue: { value in
                self.error.send((value,!value.isEmpty ? true : false))
                print("눌림\(value) \(!value.isEmpty ? true : false)")
            }.store(in: &cancel)
    }
    func fetchVotedCandidateList(userId:String){
        APIService.requset(router: .votedCandidateList(userId: userId))
            .sink { completion in
                switch completion {
                case .finished:
                    print("유저 투표 투표자 프로필 조회 API 호출 성공")
                case .failure(let error):
                    print("유저 투표 투표자 프로필 조회 API 호출 실패: \(error.localizedDescription)")
                }
            } receiveValue: { (value:[Int]) in
                self.votedCandidateList = value
            }.store(in: &cancel)
    }
}
