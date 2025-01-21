//
//  MainPoster.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/21/25.
//

import SwiftUI

struct MainPoster: View {
    var body: some View {
        Image("IMG_MAIN")
            .resizable()
            .overlay {
                VStack{
                    Spacer().frame(height: 30)
                    Text("WORLD MISS UNIVERSITY")
                        .font(.KantumruyProMedium(28))
                        .padding(.bottom,10)
                    Text("CAMBODIA 2024")
                        .font(.KantumruyProLight(22))
                    Spacer()
                    Text("Cast your vote for the brightest cadidate!\nWorld Miss University voting starts now!")
                        .font(.KantumruyProLight(16))
                        .opacity(0.7)
                }
                .foregroundStyle(.white)
            }
            .ignoresSafeArea(.keyboard)
            .frame(height:bounds.width)
            .padding(.bottom)
    }
}

#Preview {
    MainPoster()
}
