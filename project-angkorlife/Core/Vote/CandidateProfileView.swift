//
//  CandidateProfileView.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/20/25.
//

import SwiftUI
import Kingfisher

struct CandidateProfileView: View {
    let id:Int
    @EnvironmentObject var vm:VoteViewModel
    var body: some View {
        
        ScrollView(showsIndicators: false){
            if let list = vm.candidate?.profileInfoList{
                Carousel(items: list){ item in
                    KFImage(URL(string:item.profileUrl))
                        .resizable()
                        .background(.gray.opacity(0.1))
                }
            }
        }
        .onAppear{
            vm.fetchCandidate(id: id, userId: vm.userId)
        }
    }
}

#Preview {
    CandidateProfileView(id:59)
        .environmentObject(VoteViewModel())
}

