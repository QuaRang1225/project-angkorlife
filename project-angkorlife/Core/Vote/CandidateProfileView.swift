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
    @State var showAlert = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm:VoteViewModel
    
    //투표 유무에 따라 버튼 타입을 바꾸기 위함
    var voted:Bool{
        vm.candidate?.voted ?? false
    }
    //그룹박스의 텍스트 타입 재사용성을 위한 커스텀 배열(타이틀,내용)
    var infoList:[(title:String,content:String)]{
        guard let candidate = vm.candidate else {return []}
        return [
            ("Education",candidate.education),
            ("Major",candidate.major),
            ("Hobbied",candidate.hobby),
            ("Talent",candidate.talent),
            ("Ambition",candidate.ambition)
            ]
    }
    var body: some View {
        VStack{
            dismissButtonView
            ScrollView(showsIndicators: false){
                VStack{
                    if let candidate = vm.candidate{
                        carouselView(candidate)
                        VStack(alignment: .leading){
                            profileTitleView(candidate)
                            groupBoxView
                        }
                        .padding(10)
                        footerView
                    }
                    else{
                        refreshView
                    }
                }
                .foregroundStyle(.white)
            }
            .refreshable {
                vm.candidate = nil
                vm.fetchCandidate(id: id, userId: vm.userId ?? "")
            }
            voteButtonView
        }
        .alert(isPresented: $showAlert){ alert }
        .background(.black)
        .onAppear{ vm.fetchCandidate(id: id, userId: vm.userId ?? "") }
        .onDisappear{ vm.candidate = nil }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CandidateProfileView(id:59)
        .environmentObject(VoteViewModel())
}

extension CandidateProfileView{
    //뒤로가기 버튼
    var dismissButtonView:some View{
        HStack{
            Button{
                dismiss()
            } label:{
                Image(systemName: "chevron.left")
                    .foregroundStyle(.white)
                    .font(.KantumruyProBold(20))
            }
            .padding(10)
            Spacer()
        }
    }
    //캐러셀 뷰
    func carouselView(_ candidate:Candidate)->some View{
        Carousel(items: candidate.profileInfoList){ item in
            KFImage(URL(string:item.profileUrl))
                .resizable()
                .background(.gray.opacity(0.1))
        }
    }
    //이름 및 엔트리넘버
    func profileTitleView(_ candidate:Candidate)->some View{
        VStack(alignment: .leading){
            Text(candidate.name)
                .font(.KantumruyProBold(30))
                .foregroundStyle(.white)
            Text("Entry no.\(candidate.candidateNumber)")
                .font(.KantumruyProBold(20))
                .foregroundStyle(.indigo)
        }
    }
    //그룹박스
    var groupBoxView:some View{
        GroupBox{
            VStack(alignment: .leading,spacing: 10) {
                ForEach(infoList,id: \.0){ info in
                    Text(info.title)
                        .foregroundStyle(.gray.opacity(0.7))
                        .font(.KantumruyProMedium(18))
                    Text(info.content)
                        .foregroundStyle(.white)
                        .font(.KantumruyProMedium(20))
                    if let last = infoList.last,last != info { Divider() }
                }
            }
            .padding()
        }
        .colorScheme(.dark)
    }
    //푸터 뷰
    var footerView:some View{
        Text("COPYRIGHT © WUPSC ALL RIGHT RESERVED.")
            .foregroundStyle(.white)
            .font(.KantumruyProMedium(15))
            .padding(.vertical,30)
    }
    //투표 버튼
    var voteButtonView:some View{
        SelectButton(text:voted ? "Voted":"Vote", height: 55, textColor:voted ? .indigo: .white, buttonColor: voted ? .white:.indigo,image:voted ? "IMG_VOTE" : "") {
            //투표가 되지 않았거나 투표를 3번 이하로 했을때
            if !voted,vm.votedCandidateList.count < 3{
                showAlert = true
                vm.candidate?.voted.toggle()
            }
            vm.sendVote(userId: vm.userId ?? "", id: id)
        }
        .padding([.top,.horizontal])
    }
    //새로고침 화면
    var refreshView:some View{
        VStack{
            Image(systemName: "arrow.down")
                .font(.largeTitle)
                .padding(.bottom,5)
            Text("Unable to load page")
                .font(.KantumruyProMedium(25))
            Text("Pull down to refresh..")
                .font(.KantumruyProMedium(17.5))
        }
    }
    private var alert:Alert{
        let title = Text("Voting completed")
        let message = Text("Thank you for voting")
        let dismiss = Alert.Button.default(Text("Confirm"))
        return Alert(title: title,message: message,dismissButton: dismiss)
    }
}

