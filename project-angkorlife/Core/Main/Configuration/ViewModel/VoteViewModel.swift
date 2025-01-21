//
//  VoteViewModel.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/20/25.
//

import Foundation
import Combine

class VoteViewModel:ObservableObject{
    
    @Published var isLoggined = false                                           //로그인 성공 유무
    @Published var candidateList:CandidateList? = nil                           //투표자 리스트
    @Published var candidate:Candidate? = nil                                   //투표자 상세정보
    @Published var votedCandidateList:[Int] = []                                //유저가 투표한 참여자 리스트
    @Published var userId:String? = UserDefaultsManager.instance.getUserId()    //유저 Id
        
    var error = PassthroughSubject<(String,Bool),Never>()               //경고팝업을 띄우기 위한 Subject
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
                self.error.send((value,!value.isEmpty ? true : false))  //예외가 생겼을 경우의 응답 메세지를 받아 경고를 출력하기 위한 이벤트
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
