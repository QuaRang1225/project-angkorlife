//
//  TimerView.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/18/25.
//

import SwiftUI

struct TimerView: View {
    
    //Scene의 크기(해당 기기에서의 뷰의 크기 감지)
    private let bounds = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.screen.bounds
    @StateObject var timerViewModel = TimerViewModel()
    
    var body: some View {
        VStack{
            Spacer()
            Image("IMG_MAIN")
                .resizable()
                .frame(height:bounds?.width)
            HStack(spacing:10){
                ForEach(0..<4){ index in
                    RoundedRectangle(cornerRadius: 3)
                        .frame(width: 60, height: 60)
                        .foregroundStyle(.gray.opacity(0.1))
                        .overlay {
                            Text(timerViewModel.remainingTime[index])
                                .foregroundStyle(.white)
                        }
                        .overlay(alignment: .bottom) {
                            Text(timerViewModel.unit[index])
                                .offset(y:30)
                                .font(.KantumruyProMedium(18))
                        }
                    if timerViewModel.remainingTime.count-1 > index{
                        Text(":")
                            .foregroundStyle(.white)
                    }
                }
            }
            .padding(.top)
            Spacer()
            Image("IMG_EARTH")
                .resizable()
                .frame(height:(bounds?.width ?? 0)/3)
        }
        .font(.KantumruyProMedium(25))
        .foregroundStyle(.white)
        .background(.black)
        .ignoresSafeArea()
    }
}

#Preview {
    TimerView()
}
