//
//  SelectButton.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/18/25.
//

import SwiftUI

struct SelectButton: View {
    
    let text:String
    let height:CGFloat
    let textColor:Color
    let buttonColor:Color
    let action:()->()
    
    var body: some View {
        Button{
            action()
        }label:{
            Capsule()
                .foregroundStyle(.indigo)
                .frame(height:height)
                .overlay {
                    Text("Log in")
                        .foregroundStyle(.white)
                        .font(.KantumruyProBold(18))
                }
        }
    }
}

#Preview {
    SelectButton(text:"확인", height: 55,textColor: .white,buttonColor: .indigo){
        print("adasd")
    }
}
