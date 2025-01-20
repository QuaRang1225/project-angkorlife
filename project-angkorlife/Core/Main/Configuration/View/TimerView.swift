//
//  TimerView.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/18/25.
//

import SwiftUI

struct TimerView: View {

    @StateObject var timerViewModel = TimerViewModel()
    
    var body: some View {
        VStack{
            Spacer()
            overviewImageView
            timerView
            Spacer()
            backgroundEarthView
        }
        .alert(isPresented: $timerViewModel.expired){ alert }
        .font(.KantumruyProMedium(25))
        .foregroundStyle(.white)
        .padding(.top,50)
        .background(.black)
    }
}

#Preview {
    TimerView()
}

extension TimerView{
    //오버 뷰
    private var overviewImageView:some View{
        Image("IMG_MAIN")
            .resizable()
            .frame(height:bounds.width)
    }
    //타이머 뷰
    private var timerView:some View{
        HStack(spacing:10){
            ForEach(0..<4){ index in
                RoundedRectangle(cornerRadius: 3)
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.gray.opacity(0.1))
                    .overlay {
                        Text(timerViewModel.remainingTime[index])
                    }
                    .overlay(alignment: .bottom) {
                        Text(timerViewModel.unit[index])
                            .offset(y:30)
                            .font(.KantumruyProMedium(18))
                    }
                if timerViewModel.remainingTime.count-1 > index{
                    Text(":")
                }
            }
        }
        .foregroundStyle(.white)
        .padding(.vertical,20)
    }
    //배경 지구
    private var backgroundEarthView:some View{
        Image("IMG_EARTH")
            .resizable()
            .frame(height:bounds.width/3)
    }
    //투표시간 마감 경고 메세지
    private var alert:Alert{
        let title = Text("Voting time is closed")
        let dismiss = Alert.Button.default(Text("Confirm"))
        return Alert(title: title,dismissButton: dismiss)
    }
}
