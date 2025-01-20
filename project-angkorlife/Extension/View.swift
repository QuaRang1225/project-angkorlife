//
//  View.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/20/25.
//

import Foundation
import SwiftUI

extension View{
    //Scene의 크기(해당 기기에서의 뷰의 크기 감지)
    var bounds:CGRect{
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.screen.bounds ?? CGRect()
    }
}
