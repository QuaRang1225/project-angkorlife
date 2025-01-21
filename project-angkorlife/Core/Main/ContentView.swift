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
            navigationView
            logoutButtonView
        }
        .environmentObject(vm)
        .onAppear{ isLoggedIn = vm.userId == nil }
        .fullScreenCover(isPresented:$isLoggedIn){
            SignInView()
                .environmentObject(vm)
        }
    }
}

#Preview {
    ContentView()
}

extension ContentView{
    //메인화면
    var navigationView:some View{
        NavigationView{
            ScrollView(showsIndicators: false){
                VStack(spacing:0){
                    TimerView()
                    InformationView()
                    VotingCandidaterListView()
                }
            }
            .background(Color.black)
            .ignoresSafeArea()
        }
    }
    //로그아웃
    //로그아웃 시 후보자 리스트 관련 내용 삭제
    //유저ID 디바이스 내부에서 삭제
    var logoutButtonView:some View{
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
}
