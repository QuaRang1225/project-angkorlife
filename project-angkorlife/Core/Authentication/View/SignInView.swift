//
//  SignInView.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/18/25.
//

import SwiftUI

struct SignInView: View {
    
    @State var id = ""
    @State var showErrorMessage = false
    @Environment(\.dismiss) var dismiss
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
            SelectButton(text:"Log in",height:55,textColor:.white,buttonColor: .indigo){
                guard !id.isEmpty else { return showErrorMessage = true }
                UserDefaultsManager.instance.signIn(id:id)
                dismiss()
            }
            .padding(10)
            if showErrorMessage{
                Text("Please enter ID..").foregroundStyle(.red)
            }
            
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

