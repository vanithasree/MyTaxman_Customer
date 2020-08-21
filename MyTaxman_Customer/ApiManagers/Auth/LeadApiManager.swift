//
//  LeadApiManager.swift
//  MyTaxman_Customer
//
//  Created by Apple on 26/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import Alamofire

enum LeadsApi {
    case cusbooktask_beforelogin
    case cus_posttask
    case send_notification_cus_taskposted
    case send_notification_allven_newtaskposted
    
    case custasklist
    case completedtask
    case closedtask
}
// MARK: - EndPointType
extension LeadsApi: EndPointType {
    
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
            
        case .cusbooktask_beforelogin:
            return "/cusbooktask_beforelogin"
        case .cus_posttask:
            return "/cus_posttask"
        case .send_notification_cus_taskposted:
            return "/send_notification_cus_taskposted"
        case .send_notification_allven_newtaskposted:
            return "/send_notification_allven_newtaskposted"
        case .custasklist:
            return "/custasklist"
        case .completedtask:
            return "/completedtask"
        case .closedtask:
            return "/closedtask"
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
        case .cusbooktask_beforelogin:
            return nil
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

class LeadApiManager {
    
    func postTaskBeforeLogin(input: Parameters, handler: @escaping (_ result: PostJobBaseForNewCustomer?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: LeadsApi.cusbooktask_beforelogin, params: input) { (result: PostJobBaseForNewCustomer?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    
    func postTaskForLoggedInCustomer(input: Parameters, handler: @escaping (_ result: PostJobForLoggedInCustomer?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: LeadsApi.cus_posttask, params: input) { (result: PostJobForLoggedInCustomer?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    
    func getCusTaskList(input: Parameters, handler: @escaping (_ result: CustTaskListBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: LeadsApi.custasklist, params: input) { (result: CustTaskListBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    
    func getCusCompletedTaskList(input: Parameters, handler: @escaping (_ result: CompletedTaskListBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: LeadsApi.completedtask, params: input) { (result: CompletedTaskListBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    
    func getCusClosedTaskList(input: Parameters, handler: @escaping (_ result: ClosedJobListBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: LeadsApi.closedtask, params: input) { (result: ClosedJobListBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }

}
