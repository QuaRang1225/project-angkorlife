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
            if vm.isLoggined{
                loginSuccessTextView
            }
        }
        .environmentObject(vm)
        .onAppear{ isLoggedIn = vm.userId == nil }
        .onChange(of: vm.isLoggined){ _ in
            DispatchQueue.main.asyncAfter(deadline: .now()+3){
                withAnimation(.easeInOut(duration: 0.5)){
                    vm.isLoggined = false
                }
            }
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
    //로그인 성공 문구
    var loginSuccessTextView:some View{
        Text("Login completed successfully")
            .foregroundStyle(.white)
            .font(.KantumruyProMedium(18))
            .padding(10)
            .padding(.horizontal)
            .background(.gray.opacity(0.5))
            .cornerRadius(3)
            .frame(maxWidth: .infinity,maxHeight: .infinity)
    }
}
