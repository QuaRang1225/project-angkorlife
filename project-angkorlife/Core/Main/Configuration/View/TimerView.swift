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
    
    var body: some View {
        VStack{
            Image("IMG_MAIN")
                .resizable()
                .frame(height:bounds?.width)
            HStack(spacing:10){
                
            }
            Image("IMG_EARTH")
                .resizable()
                .frame(height:(bounds?.width ?? 0)/3)
        }
    }
}

#Preview {
    TimerView()
}
