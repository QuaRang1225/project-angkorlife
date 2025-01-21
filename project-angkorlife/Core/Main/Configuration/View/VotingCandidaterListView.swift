//
//  VotingParticipantsListView.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/18/25.
//

import SwiftUI

struct VotingCandidaterListView: View {
    let columns = [GridItem(),GridItem()]           //그리드 아이템 수
    @State var isError = (message:"",event:false)     //투표 요청 시 받아오는 데이터를 경고팝업에 띄우기 위함
    @EnvironmentObject var vm:VoteViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            headerView
            candidateListView
            footerView
        }
        .foregroundStyle(.white)
        .padding(.vertical,20)
        .padding(10)
        .background(.black)
        .onAppear(perform: appear)
        .onReceive(vm.error){ recive(message: $0, event: $1) }
        .alert(isPresented: $isError.event){ alert }
    }
}

#Preview {
    ScrollView {
        VotingCandidaterListView()
            .environmentObject(VoteViewModel())
    }
}

extension VotingCandidaterListView{
    //경고팝업
    private var alert:Alert{
        let title = Text(isError.message)
        let button = Alert.Button.cancel(Text("Confirm"))
        return Alert(title: title,dismissButton: button)
    }
    //뷰가 나타났을 떄 실행
    private func appear(){
        vm.fetchCandidateList()
        vm.fetchVotedCandidateList(userId: vm.userId ?? "")
    }
    //투표 진행 후 예외를 위해 경고 알림을 띄워야할 떄 실행
    private func recive(message:String,event:Bool){
        isError.event = event
        isError.message = message
    }
    //헤더 뷰
    private var headerView:some View{
        VStack(alignment: .leading, spacing: 10){
            Divider()
                .frame(width: 30,height: 5)
                .background(.indigo)
            Text("2024\nCadidate List")
                .font(.KantumruyProBold(40))
            HStack{
                Text("※ You can vote for up to 3 candidates")
                    .font(.KantumruyProLight(16))
                    .foregroundStyle(.gray)
                Spacer()
                Button {
                    vm.candidateList = nil
                    vm.votedCandidateList.removeAll()
                    appear()
                } label: {
                    Image(systemName:"arrow.clockwise")
                        .rotationEffect(Angle(degrees:45))
                }
            }
        }
    }
    //투표참여자 리스트 뷰
    @ViewBuilder
    private var candidateListView:some View{
        if let content = vm.candidateList?.content{
            LazyVGrid(columns: columns) {
                ForEach(content,id:\.self) { profile in
                    VotingCandidaterListRowView(profile:profile)
                        .environmentObject(vm)
                }
            }
        }else{
            VotingCandidaterSkeletionListView()
        }
    }
    //푸터 뷰
    private var footerView:some View{
        Text("COPYRIGHT © WUPSC ALL RIGHT RESERVED.")
            .font(.KantumruyProLight(15))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.top,30)
    }
}
