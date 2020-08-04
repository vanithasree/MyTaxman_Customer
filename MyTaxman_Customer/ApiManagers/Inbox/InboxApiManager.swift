//
//  InboxApiManager.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 04/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import Alamofire

enum InboxApi {
    case cusinboxlist
    case chat
    case send_chat
    case venprofile
    case hire_technician
    case ven_quote_decline_bycustomer
}

// MARK: - EndPointType
extension InboxApi: EndPointType {
    
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
            
        case .cusinboxlist:
            return "/cusinboxlist"
        case .chat:
            return "/chat"
        case .send_chat:
            return "/send_chat"
        case .venprofile:
            return "/venprofile"
        case .hire_technician:
            return "/hire_technician"
        case .ven_quote_decline_bycustomer:
            return "/ven_quote_decline_bycustomer"
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


class InboxApiManager {
    
    func requestCusinboxlist(input: Parameters, handler: @escaping (_ result: InboxListBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: InboxApi.cusinboxlist, params: input) { (result: InboxListBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    
    func requestChat(input: Parameters, handler: @escaping (_ result: ChatBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: InboxApi.chat, params: input) { (result: ChatBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    
    func requestSendChat(input: Parameters, handler: @escaping (_ result: SendChatBase?, _ error: AlertMessage?)->()) {
         APIManager.shared().call(type: InboxApi.send_chat, params: input) { (result: SendChatBase?,message: AlertMessage?) in
             if let result = result {
                 handler(result, nil)
             } else {
                 handler(nil, message!)
             }
         }
     }
    
    func requestVenProfile(input: Parameters, handler: @escaping (_ result: CheckMobile_Base?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: InboxApi.venprofile, params: input) { (result: CheckMobile_Base?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    func requestHireTechnician(input: Parameters, handler: @escaping (_ result: ResendOtpBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: InboxApi.hire_technician, params: input) { (result: ResendOtpBase?, message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    
    func requestVen_quote_decline_bycustomer(input: Parameters, handler: @escaping (_ result: OtpVerifyBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: InboxApi.ven_quote_decline_bycustomer, params: input) { (result: OtpVerifyBase?, message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    
}
