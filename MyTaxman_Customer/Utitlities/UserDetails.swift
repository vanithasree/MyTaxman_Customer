//
//  UserDetails.swift
//  jps
//
//  Created by vijaykarthik on 15/04/20.
//  Copyright © 2020 vijaykarthik. All rights reserved.
//

import Foundation
import Alamofire

struct UserDetails {

    static var shared: UserDetails = UserDetails()
    
    var temp: Parameters?
    
    func setUserLoginData(data: Data) {
        UserDefaults.standard.set(data, forKey: "user_login")
        UserDefaults.standard.synchronize()
    }
    
    var userLoginData: Customerid? {
        if let loginData = UserDefaults.standard.data(forKey: "user_login") {
            do {
                let loginDetail = try JSONDecoder().decode(Customerid.self, from: loginData)
                return loginDetail
            } catch _ {
                return nil
            }
            
        } else {
            return nil
        }
    }
    
    var userId: String {
        userLoginData?.customerid ?? ""
    }
    
    var accessToken: String {
//        userLoginData?.result?.accessToken ?? ""
        ""
    }
    
    var isLoggedIn: Bool {
        return !(userLoginData?.customerid ?? "").isBlank
    }
    
    mutating func logout() {
        UserDefaults.standard.removeObject(forKey: "user_login")
        clearLocalContent()
    }
    
    func clearLocalContent() {
        let fileManager = FileManager.default
        let myDocuments = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        guard let filePaths = try? fileManager.contentsOfDirectory(at: myDocuments, includingPropertiesForKeys: nil, options: []) else { return }
        print(filePaths)
        for filePath in filePaths {
            try? fileManager.removeItem(at: filePath)
        }
    }
    
    func clearLocalContent(filePath: URL) {
        let fileManager = FileManager.default
        try? fileManager.removeItem(at: filePath)
    }
}
