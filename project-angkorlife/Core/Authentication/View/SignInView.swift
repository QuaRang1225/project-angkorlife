//
//  SignInView.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/18/25.
//

import SwiftUI

struct SignInView: View {
    
    @State private var id = ""                      //ID정보
    @State private var showErrorMessage = false     //ID를 입력하지 않을 시 에러문구 표시 유무
    @Environment(\.dismiss) private var dismiss     //해당 뷰 닫음
    @EnvironmentObject var vm:VoteViewModel
    //Scene의 크기(해당 기기에서의 뷰의 크기 감지)
    private let bounds = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.screen.bounds

    var body: some View {
        VStack{
            Spacer()
            overviewImageView
            textFieldView
            signInButtonView
            errorMessageView
            Spacer()
            backgroundEarthView
        }
        .ignoresSafeArea()
        .background(.black)
    }
}


#Preview {
    SignInView()
        .environmentObject(VoteViewModel())
}

extension SignInView{
    //오버뷰 이미지
    private var overviewImageView:some View{
        Image("IMG_MAIN")
            .resizable()
            .frame(height:bounds?.width)
    }
    //아이디 입력 텍스트 필드
    private var textFieldView:some View{
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
            .font(.KantumruyProRegular(18))
    }
    //로그인 버튼
    private var signInButtonView:some View{
        SelectButton(text:"Log in",height:55,textColor:.white,buttonColor: .indigo){
            guard !id.isEmpty else { return showErrorMessage = true }
            UserDefaultsManager.instance.signIn(id:id)
            vm.userId = id
            vm.fetchCandidateList()
            vm.fetchVotedCandidateList(userId: id)
            dismiss()
        }
        .padding(10)
    }
    //에러 메세지 출력
    @ViewBuilder
    private var errorMessageView:some View{
        if showErrorMessage{
            Text("Please your enter ID..").foregroundStyle(.red)
        }
    }
    //배경 지구
    private var backgroundEarthView:some View{
        Image("IMG_EARTH")
            .resizable()
            .frame(height:(bounds?.width ?? 0)/3)
    }
}
