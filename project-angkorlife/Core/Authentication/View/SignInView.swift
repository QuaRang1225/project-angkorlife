//
//  SignInView.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/18/25.
//

import SwiftUI

struct SignInView: View {
    
    @State var id = ""
    private let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
    

    var body: some View {
        VStack{
            Spacer()
            Image("IMG_MAIN")
                .resizable()
                .frame(height:windowScene?.screen.bounds.width)
            TextField("Enter your ID",text: $id)
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(.gray)
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundStyle(.gray.opacity(0.1))
                }
                .padding(10)
                .foregroundStyle(.white)
            Button{
                
            }label:{
                Capsule()
                    .foregroundStyle(.indigo)
                    .frame(height:55)
                    .overlay {
                        Text("Log in")
                            .foregroundStyle(.white)
                            .font(.KantumruyProBold(18))
                    }
            }
            .padding(10)
            Spacer()
            Image("IMG_EARTH")
                .resizable()
                .frame(height:(windowScene?.screen.bounds.width ?? 0)/3)
                
        }
        .ignoresSafeArea()
        .background(.black)
    }
}


#Preview {
    SignInView()
}
