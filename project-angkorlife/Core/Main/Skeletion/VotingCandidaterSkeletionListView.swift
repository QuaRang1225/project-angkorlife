//
//  VotingCandidaterSkeletionView.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/21/25.
//

import SwiftUI

struct VotingCandidaterSkeletionListView: View {
    let columns = [GridItem(),GridItem()] 
    @State var timer:Timer?
    @State var cycle = false
    var body: some View {
        ZStack(alignment:.top){
            LazyVGrid(columns: columns) {
                ForEach(0..<20,id:\.self) { _ in
                    VStack{
                        LinearGradient(colors: [.gray.opacity(0.05),.clear], startPoint: cycle ? .topLeading : .bottomTrailing, endPoint:cycle ? .bottomTrailing : .topLeading)
                            .frame(height: bounds.width/2 - 10)
                        LinearGradient(colors: [.gray.opacity(0.05),.clear], startPoint: cycle ? .topLeading : .bottomTrailing, endPoint:cycle ? .bottomTrailing : .topLeading)
                            .frame(height: 18)
                        LinearGradient(colors: [.gray.opacity(0.05),.clear], startPoint: cycle ? .topLeading : .bottomTrailing, endPoint:cycle ? .bottomTrailing : .topLeading)
                            .frame(height: 15)
                        LinearGradient(colors: [.gray.opacity(0.05),.clear], startPoint: cycle ? .topLeading : .bottomTrailing, endPoint:cycle ? .bottomTrailing : .topLeading)
                            .frame(height: 40)
                    }
                }
            }
            .foregroundStyle(.gray.opacity(0.1))
            ProgressView()
                .colorScheme(.dark)
                .controlSize(.large)
                .padding(.top,30)
        }
        .onAppear{
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ time in
                withAnimation (.linear(duration: 1)){
                    cycle.toggle()
                }
            }
        }
        .background(.black)
        
    }
}

#Preview {
    VotingCandidaterSkeletionListView()
}
