//
//  VotingParticipantsListView.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/18/25.
//

import SwiftUI

struct VotingParticipantsListView: View {
    let columns = [GridItem(),GridItem()]
    @StateObject var vm = VoteViewModel()
    @State var event = false
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let content = vm.candidateList?.content{
                Divider()
                    .frame(width: 30,height: 5)
                    .background(.indigo)
                Text("2024\nCadidate List")
                    .font(.KantumruyProBold(40))
                Text("※ You can vote for up to 3 candidates")
                    .font(.KantumruyProLight(16))
                    .foregroundStyle(.gray)
                LazyVGrid(columns: columns) {
                    ForEach(content,id:\.self) { profile in
                        
                        VotingParticipantsListRowView(profile: profile)
                    }
                }
                Text("COPYRIGHT © WUPSC ALL RIGHT RESERVED.")
                    .font(.KantumruyProLight(15))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.top,30)
            }
        }
        .foregroundStyle(.white)
        .padding(.vertical,20)
        .background(.black)
        .onAppear{
            vm.fetchCandidateList()
        }
    }
}

#Preview {
    ScrollView {
        VotingParticipantsListView()
    }
}
