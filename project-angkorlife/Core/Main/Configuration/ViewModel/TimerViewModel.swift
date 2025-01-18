//
//  TimerManager.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/18/25.
//

import Foundation
import SwiftUI
class TimerViewModel:ObservableObject{
    
    @Published var remainingTime = ["","","",""]                                    //시간이 지남에 따라 업데이트 되는 시간단위 리스트(일,시간,분,초)
    @Published var expired = false                                                  //투표시간 마감 유무
    let unit = ["DAY","HR","MIN","SEC"]                                             //해당 시간단위를 나타내는 문자열 리스트
    private let deadLine = Date().stringToDate("2025-01-03 00:00:00") ?? Date()     //투표마감시간 설정
    private var timer: Timer?                                                       //타이머 선언
    
    //ViewModel이 초기화될때 카운트다운 시작
    init(){
        countDown()
    }
    //카운트 다운메서드
    //1초에 시간이 경과 될때 투표마감시간이 되지 않을 경우, 남은시간 계산 메서드 실행
    //투표시간이 마감됐을 경우 시간을 00:00:00:00으로 초기화하고 timer를 초기화하며 경고표시를 띄울 변수를 업데이트
    func countDown(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ [weak self] _ in
            guard let self else { return }
            if self.deadLine <= Date(){
                timer?.invalidate()
                timer = nil
                remainingTime = ["00","00","00","00"]
                expired = true
            }else{
                DispatchQueue.main.async {
                    withAnimation(.bouncy){
                        self.calculateRemainingTime()
                    }
                }
            }
        }
    }
    //남은시간 계산 메서드
    //마감시간에서 현재시간의 차이를 구함
    //만약 차이를 구할 수 없으면 00:00:00:00으로 세팅
    private func calculateRemainingTime(){
        let calender = Calendar.current
        guard let diff = calender.dateComponents([.day,.hour,.minute,.second], from: Date(), to: deadLine) as DateComponents? else{ return }
        let days = String(format: "%02d", diff.day ?? 0)
        let hours = String(format: "%02d", diff.hour ?? 0)
        let minutes = String(format: "%02d", diff.minute ?? 0)
        let seconds = String(format: "%02d", diff.second ?? 0)
        remainingTime = [days,hours,minutes,seconds]
    }
}


