//
//  VotingParticipantsListRowView.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/18/25.
//

import SwiftUI
import Kingfisher

struct VotingParticipantsListRowView: View {
    
    let profile:Content
    var voted:Bool{
        vm.votedCandidateList.contains(profile.id)
    }
    @EnvironmentObject var vm:VoteViewModel
    var body: some View {
        VStack{
            NavigationLink {
                
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
            SelectButton(text:voted ? "Voted":"Vote", height: 40, textColor:voted ? .indigo: .white, buttonColor: voted ? .white:.indigo) {
                if !voted,vm.votedCandidateList.count < 3{
                    vm.votedCandidateList.append(profile.id)
                }
                vm.sendVote(userId: vm.userId, id: profile.id)
            }
        }
        .padding(5)
    }
}

#Preview {
    VotingParticipantsListRowView(profile: CustomData.instance.listContent)
        .environmentObject(VoteViewModel())
        .background(.black)
}
