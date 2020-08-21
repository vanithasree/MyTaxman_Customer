//
//  SettingsApiManager.swift
//  MyTaxman_Customer
//
//  Created by Vanithasree Rajeshkumar on 21/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import Alamofire

enum SettingsApi {
    
    case cusprofile
    case cuseditprofile
    case cuschangepassword
    
}

// MARK: - EndPointType
extension SettingsApi: EndPointType {
    
    // MARK: - Vars & Lets
    
    var baseURL: String {
        switch APIManager.networkEnviroment {
        case .dev: return Constant.devURLBaseString
        case .production: return Constant.devURLBaseString
        case .stage: return Constant.devURLBaseString
        }
    }
    
    var version: String {
        return "/v0_1"
    }
    
    var path: String {
        switch self {
            
        case .cuseditprofile:
            return "/cuseditprofile"
        case .cusprofile:
            return "/cusprofile"
        case .cuschangepassword:
            return "/cuschangepassword"
            
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
            //        case .getAccount, .GetInfoByItemType, .getProfile: return .get
        //        case .updateUserProfile: return .put
        default:
            return .post
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
            //        case .login:
            //            return nil
            /*["Content-Type": "application/json",
             "X-Requested-With": "XMLHttpRequest",
             "x-access-token": "someToken"]*/
        default:
            return nil /* ["Content-Type": "application/json",
             "X-Requested-With": "XMLHttpRequest"]*/
        }
    }
    
    var url: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.path)!
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
    
}


class SettingsApiManager {
    
    func getCustomerProfile(input: Parameters, handler: @escaping (_ result: CustomerProfileBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: SettingsApi.cusprofile, params: input) { (result: CustomerProfileBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    func editCustomerProfile(input: Parameters, handler: @escaping (_ result: EditProfileBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: SettingsApi.cuseditprofile, params: input) { (result: EditProfileBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    func changeCustomerPassword(input: Parameters, handler: @escaping (_ result: ChangePasswordBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: SettingsApi.cuschangepassword, params: input) { (result: ChangePasswordBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
}
