//
//  MainView.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/18/25.
//

import SwiftUI

struct MainView: View {
    var body: some View{
        NavigationView{
            ScrollView(showsIndicators: false){
                VStack(spacing:0){
                    TimerView()
                    InformationView()
                    VotingParticipantsListView()
                }
            }
        }
    }
}

#Preview {
    MainView()
}
