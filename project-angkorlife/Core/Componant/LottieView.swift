//
//  LottieView.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/21/25.
//

import Foundation
import SwiftUI
import Lottie
import UIKit

// 로티 애니메이션 뷰
struct LottieView: UIViewRepresentable {
    var name: String
        var loopMode: LottieLoopMode = .loop
        var speed: CGFloat = 1.0
        
        private let animationView = LottieAnimationView()
        
        func makeUIView(context: Context) -> some UIView {
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = loopMode
            animationView.animationSpeed = speed
            animationView.animation = LottieAnimation.named(name)
            animationView.play()
            return animationView
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) {}
}

#Preview {
    LottieView(name: "POP",loopMode: .playOnce)
}
