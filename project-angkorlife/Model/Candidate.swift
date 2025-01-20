//
//  Candidate.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/20/25.
//

import Foundation

struct Candidate: Codable {
    let id, candidateNumber: Int
    let name, country, education, major: String
    let hobby, talent, ambition, contents: String
    let profileInfoList: [ProfileInfoList]
    let regDt: String
    let voted: Bool
}

struct ProfileInfoList: Codable {
    let fileArea, displayOrder: Int
    let profileUrl: String
    let mimeType: String
}
