//
//  CustomData.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/20/25.
//

import Foundation

class CustomData{
    static var instance = CustomData()
    private init(){}
    
    var image:String{
        "https://avatars.githubusercontent.com/u/31721255?v=4&size=64"
    }
    var listContent:Content{
        Content(id: 48, candidateNumber: 1, name: "Gana", profileUrl: "https://angkorchat-bucket.s3.ap-southeast-1.amazonaws.com/candidate/48/409425fa12d842e092a4e4db87263009.png", voteCnt: "48")
    }
}
