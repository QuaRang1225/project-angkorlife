//
//  CarouselView.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/20/25.
//

import SwiftUI

public struct Carousel<Data, Content: View>: View {
    @State var timer:Timer?
    @State var items: [Data]
    @State private var currentIndex: Int = 1
    @ViewBuilder var content: (Data) -> Content
    
    public init(items: [Data], @ViewBuilder content: @escaping (Data) -> Content) {
        self.items = items
        self.content = content
    }
    
    public var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(Array(items.enumerated()), id: \.offset) { _, item in
                self.content(item)
            }
        }
        .frame(height: bounds.width)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .overlay(alignment:.bottom){ indicatorView }
        .onAppear(perform: {setBothSideIndex()})
        .onChange(of: currentIndex) { getBothSideIndex($0) }
    }
    
}

#Preview {
    Carousel(items: [Color.red,Color.orange,Color.yellow]) { item in
        item
    }
}
extension Carousel{
    //인디케이터 뷰
    var indicatorView:some View{
        HStack{
            ForEach(1...items.count-2,id:\.self){ index in
                Capsule()
                    .frame(width:10,height: 10)
                    .foregroundStyle(index == currentIndex ? .indigo:.white.opacity(0.5))
            }
        }
        .padding()
    }
    //양쪽끝에 예비 인덱스값 추가(뷰 첫 등장 시 호출)
    private func setBothSideIndex() {
        items.insert(items[items.count - 1], at: 0)
        items.append(items[1])
        setTimer()
    }
    //만약 인덱스 범위 바깥으로 나갈경우 각 끝과 끝으로 이동
    //.withAnimation을 사용할 경우 앞으로 돌아가는 것처럼 보이나 DispatchQueue를 사용하면, 자연스러운 이동이 가능함
    //인덱스 값이 바뀔 시 호출
    private func getBothSideIndex(_ index: Int) {
        if index == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                currentIndex = items.count - 2
            }
        } else if index == items.count - 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                currentIndex = 1
            }
        }
    }
    //타이머 작동 메서드
    private func setTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true){ _ in
            withAnimation {
                self.currentIndex += 1
            }
        }
    }
}
