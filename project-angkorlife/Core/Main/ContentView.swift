//
//  ContentView.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/18/25.
//

import SwiftUI

struct ContentView: View {
    @State var isLoggedIn = false
    var body: some View {
        ZStack{
            MainView()
        }
        .onAppear{
            isLoggedIn = !UserDefaultsManager.instance.isUserLoggedIn()
        }
        .fullScreenCover(isPresented:$isLoggedIn){
            SignInView()
        }
    }
}

#Preview {
    ContentView()
}
