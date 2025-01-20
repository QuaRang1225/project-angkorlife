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
            SelectButton(text: "Vote", height: 40, textColor: .white, buttonColor: .indigo) {
                
            }
        }
        .padding(5)
    }
}

#Preview {
    VotingParticipantsListRowView(profile: CustomData.instance.listContent)
        .background(.black)
}
