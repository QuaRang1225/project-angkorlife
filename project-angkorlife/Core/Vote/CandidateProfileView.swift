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
    
    var voted:Bool{
        vm.candidate?.voted ?? false
    }
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
            ScrollView(showsIndicators: false){
                VStack{
                    if let candidate = vm.candidate{
                        Carousel(items: candidate.profileInfoList){ item in
                            KFImage(URL(string:item.profileUrl))
                                .resizable()
                                .background(.gray.opacity(0.1))
                        }
                        VStack(alignment: .leading){
                            Text(candidate.name)
                                .font(.KantumruyProBold(30))
                                .foregroundStyle(.white)
                            Text("Entry no.\(candidate.candidateNumber)")
                                .font(.KantumruyProBold(20))
                                .foregroundStyle(.indigo)
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
                        .padding(10)
                        Text("COPYRIGHT © WUPSC ALL RIGHT RESERVED.")
                            .foregroundStyle(.white)
                            .font(.KantumruyProMedium(15))
                            .padding(.vertical,30)
                    }
                }
            }
            SelectButton(text:voted ? "Voted":"Vote", height: 55, textColor:voted ? .indigo: .white, buttonColor: voted ? .white:.indigo,offset:voted ? 10:0) {
                if !voted,vm.votedCandidateList.count < 3{
                    vm.candidate?.voted.toggle()
                }
                vm.sendVote(userId: vm.userId, id: id)
            }
            .overlay{
                Image(voted ? "IMG_VOTE" : "")
                    .resizable()
                    .frame(width: 25,height: 25)
                    .offset(x:-27.5)
            }
            .padding([.top,.horizontal])
        }
        .background(.black)
        .onAppear{
            vm.fetchCandidate(id: id, userId: vm.userId)
        }
        .onDisappear{
            vm.candidate = nil
        }
    }
}

#Preview {
    CandidateProfileView(id:59)
        .environmentObject(VoteViewModel())
}

