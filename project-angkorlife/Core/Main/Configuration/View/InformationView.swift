//
//  InformationView.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/18/25.
//

import SwiftUI

struct InformationView: View {
    private let backgroundColor = LinearGradient(colors: [.black,.gray.opacity(0.1)], startPoint: .top, endPoint: .bottom)
    var body: some View {
        VStack(alignment: .leading){
            subHeadLineView
            headLineView
            calloutView
            infomationView
        }
        .padding(10)
        .padding(.vertical,30)
        .background(backgroundColor)
    }
}

#Preview {
    InformationView()
}

extension InformationView{
    //부제목 뷰
    var subHeadLineView:some View{
        Text("WORLD MISS UNIVERSITY")
            .font(.KantumruyProMedium(18))
            .foregroundStyle(.indigo)
            .padding(.bottom,10)
    }
    //제목 뷰
    var headLineView:some View{
        Text("Mobile Voting\nInformation")
            .font(.KantumruyProBold(30))
            .foregroundStyle(.white)
            .padding(.bottom,20)
    }
    //설명 뷰
    var calloutView:some View{
        Text("2024 World Miss University brings\ntogether future global leaders who embody both \nbeauty and intellect.")
            .font(.KantumruyProMedium(18))
            .foregroundStyle(.white.opacity(0.5))
            .padding(.bottom,20)
    }
    //정보 폼 뷰
    var infomationView:some View{
        GroupBox(label:
            HStack{
                Text("Period")
                    .font(.KantumruyProSemiBold(15))
            Spacer()
                Text("10/17(Thu) 12PM - 10/31(Thu) 6PM")
                    .frame(width: 240)
                    .font(.KantumruyProMedium(15))
            }
            .padding(.bottom)
        ){
            HStack(alignment: .top){
                Text("How to vote")
                    .font(.KantumruyProSemiBold(15))
                Spacer()
                VStack(alignment: .leading,spacing: 10){
                    Group{
                        Text("Up to three people can participate in early voting per day. ")
                        Text("Three new voting tickets are issued every day at midnight (00:00), and you can vote anew every day during the early voting period")
                    }
                    .font(.KantumruyProMedium(15))
                    .overlay(alignment:.topLeading){ Text("•").offset(x:-15) }
                }
                .frame(width: 240)
            }
        }
        .colorScheme(.dark)
    }
}
