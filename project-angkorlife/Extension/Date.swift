//
//  Date.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/18/25.
//

import Foundation

extension Date{
    //날짜 문자열을 날짜로 바꾸는 메서드
    func stringToDate(_ date:String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.date(from: date)!
    }
}
