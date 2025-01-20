//
//  UserDefaultsManager.swift
//  project-angkorlife
//
//  Created by 유영웅 on 1/18/25.
//

import Foundation

class UserDefaultsManager{
    static let instance = UserDefaultsManager()
    private init(){}
    
    let userId = "user_id"  //User Defaults키
    
    //로그인 유무를 판단하여 반환하는 메서드
    //true - 로그인됨 / false - 로그인 필요
    func isUserLoggedIn()->Bool{
        guard UserDefaults.standard.string(forKey:userId) == nil else { return true }
        return false
    }
    //로그인 메서드
    //id를 User Defaults에 저장
    func signIn(id:String){
        UserDefaults.standard.set(id,forKey:userId)
    }
    
    func getUserId()->String{
        return UserDefaults.standard.string(forKey: userId) ?? ""
    }
}
