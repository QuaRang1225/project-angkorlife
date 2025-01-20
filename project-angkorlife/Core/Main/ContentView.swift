//
//  ContentView.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/18/25.
//

import SwiftUI

struct ContentView: View {
    @State var isLoggedIn = false
    @StateObject var vm = VoteViewModel()
    var body: some View {
        ZStack(alignment: .topTrailing){
            NavigationView{
                ScrollView(showsIndicators: false){
                    VStack(spacing:0){
                        TimerView()
                        InformationView()
                        VotingParticipantsListView()
                    }
                }
                .background(Color.black) 
                .ignoresSafeArea()
            }
            Button {
                vm.userId = nil
                vm.candidateList = nil
                vm.votedCandidateList.removeAll()
                isLoggedIn = true
                UserDefaultsManager.instance.deleteUserId()
            } label: {
                Text("Log out")
                    .foregroundStyle(.white)
                    .font(.KantumruyProBold(20))
                    .padding()
            }
        }
        .environmentObject(vm)
        .onAppear{
            isLoggedIn = vm.userId == nil
        }
        .fullScreenCover(isPresented:$isLoggedIn){
            SignInView()
                .environmentObject(vm)
        }
    }
}

#Preview {
    ContentView()
}
