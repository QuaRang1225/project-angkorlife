//
//  VotingParticipantsListRowView.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/18/25.
//

import SwiftUI
import Kingfisher

struct VotingCandidaterListRowView: View {
    
    @State var profile:Content                                 //투표참여자의 간략한 정보
    var voted:Bool{                                     //투표진행되었음을 판단
        vm.votedCandidateList.contains(profile.id)
    }
    @EnvironmentObject var vm:VoteViewModel
    
    var body: some View {
        VStack{
            navigationLinkView
            buttonView
        }
        .padding(5)
    }
}

#Preview {
    VotingCandidaterListRowView(profile: CustomData.instance.listContent)
        .environmentObject(VoteViewModel())
        .background(.black)
}

extension VotingCandidaterListRowView{
    //투표 참여자 상세프로필 이동
    var navigationLinkView:some View{
        NavigationLink {
            CandidateProfileView(id: profile.id)
                .environmentObject(vm)
        } label: {
            VStack{
                KFImage(URL(string:profile.profileUrl))
                    .resizable()
                    .frame(height: bounds.width/2-10)
                Text(profile.name)
                    .font(.KantumruyProMedium(20))
                    .foregroundStyle(.white)
                Text("\(profile.voteCnt) voted")
                    .font(.KantumruyProMedium(17))
                    .foregroundStyle(.indigo)
            }
        }
    }
    //투표 버튼
    var buttonView:some View{
        SelectButton(text:voted ? "Voted":"Vote", height: 40, textColor:voted ? .indigo: .white, buttonColor: voted ? .white:.indigo) {
            if !voted,vm.votedCandidateList.count < 3{
                vm.votedCandidateList.append(profile.id)
                profile.voteCnt = "\((Int(profile.voteCnt)!) + 1)"
            }
            vm.sendVote(userId: vm.userId ?? "", id: profile.id)
        }
    }
}
