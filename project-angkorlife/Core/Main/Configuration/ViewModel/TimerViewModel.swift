//
//  TimerManager.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/18/25.
//

import Foundation

class TimerViewModel{
    
    private var deadLine = Date()
    private var timer: Timer?   //타이머 선언
    
    func countDown(onComplete:(()->())?){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false){ [weak self] _ in
            guard let self else { return }
            if self.deadLine <= Date(){
                onComplete?()
            }
            let
        }
    }
    
}

extension Date{
    func stringToDate(_ date:String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = date
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.date(from: date)!
    }
}
