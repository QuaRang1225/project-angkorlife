//
//  VoteViewModel.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/20/25.
//

import Foundation
import Combine

class VoteViewModel:ObservableObject{
    
    @Published var voteCandidateList:VoteCandidateList? = nil
    var cancel = Set<AnyCancellable>()
    
    func fetchVoteCandidateList(){
        APIService.requset(router: .candidateList)
            .sink { completion in
                switch completion {
                case .finished:
                    print("API 호출 성공")
                case .failure(let error):
                    print("API 호출 실패: \(error.localizedDescription)")
                }
            } receiveValue: { (value:VoteCandidateList) in
                self.voteCandidateList = value
            }.store(in: &cancel)
    }
}
