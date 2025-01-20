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
    
    //로그인 메서드
    //id를 User Defaults에 저장
    func signIn(id:String){
        UserDefaults.standard.set(id,forKey:userId)
    }
    //유저 Id 불러오는 메서드
    func getUserId()->String?{
        return UserDefaults.standard.string(forKey: userId)
    }
    //로그아웃 메서드
    func deleteUserId(){
        UserDefaults.standard.removeObject(forKey: userId)
    }
}
