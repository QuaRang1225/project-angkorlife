//
//  VoteCandidateList.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/20/25.
//

import Foundation

struct VoteCandidateList: Codable {
    let content: [Content]
    let pageable: Pageable
    let totalPages, totalElements: Int
    let last: Bool
    let size, number: Int
    let sort: Sort
    let numberOfElements: Int
    let first, empty: Bool
}
struct Content: Codable {
    let id, candidateNumber: Int
    let name: String
    let profileUrl: String
    let voteCnt: String

}
struct Pageable: Codable {
    let sort: Sort
    let offset, pageNumber, pageSize: Int
    let paged, unpaged: Bool
}
struct Sort: Codable {
    let empty, sorted, unsorted: Bool
}
