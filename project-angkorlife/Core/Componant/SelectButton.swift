//
//  SelectButton.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/18/25.
//

import SwiftUI

struct SelectButton: View {
    
    let text:String         //텍스트 문자열
    let height:CGFloat      //버튼 높이
    let textColor:Color     //버튼 색상
    let buttonColor:Color   //버튼 텍스트 색상
    var image:String?     //버튼 가로 위치
    let action:()->()       //버튼 이벤트
    
    var body: some View {
        Button{
            action()
        }label:{
            Capsule()
                .foregroundStyle(buttonColor)
                .frame(height:height)
                .overlay {
                    Label {
                        Text(text)
                            .foregroundStyle(textColor)
                            .font(.KantumruyProBold(18))
                    } icon: {
                        Image(image ?? "")
                            .offset(x:5)
                    }
                }
        }
    }
}

#Preview {
    SelectButton(text:"확인", height: 55,textColor: .white,buttonColor: .indigo){
        print("adasd")
    }
}
