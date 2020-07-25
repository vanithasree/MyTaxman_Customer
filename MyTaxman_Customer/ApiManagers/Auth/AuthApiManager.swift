//
//  AuthApiManager.swift
//  jps
//
//  Created by Kathiresan on 14/05/20.
//  Copyright © 2020 vijaykarthik. All rights reserved.
//

import Foundation
import Alamofire

enum AuthApi {
    case login
    case signUp
    case forgotPassword
    case mobileemail_exist
    case resend_otp
    case cus_otpverification
}

// MARK: - EndPointType
extension AuthApi: EndPointType {
    
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
            
        case .login:
            return "/cuslogin"
        case .signUp:
            return "/customerregister"
        case .forgotPassword:
            return "/cusforgotpassword"
        case .mobileemail_exist:
            return "/mobileemail_exist"
        case .resend_otp:
            return "/resend_otp"
        case .cus_otpverification:
            return "/cus_otpverification"
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
        case .login:
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


class AuthApiManager {
    
    func requestLogIn(input: Parameters, handler: @escaping (_ result: LoginBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: AuthApi.login, params: input) { (result: LoginBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    
    func requestSignup(input: Parameters, handler: @escaping (_ result: Register_Base?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: AuthApi.signUp, params: input) { (result: Register_Base?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    
    func requestForgotPassword(input: Parameters, handler: @escaping (_ result: ForgotPasswordBase?, _ error: AlertMessage?)->()) {
         APIManager.shared().call(type: AuthApi.forgotPassword, params: input) { (result: ForgotPasswordBase?,message: AlertMessage?) in
             if let result = result {
                 handler(result, nil)
             } else {
                 handler(nil, message!)
             }
         }
     }
    
    func requestCheckMobile(input: Parameters, handler: @escaping (_ result: CheckMobile_Base?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: AuthApi.mobileemail_exist, params: input) { (result: CheckMobile_Base?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    func requestResendOtp(input: Parameters, handler: @escaping (_ result: ResendOtpBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: AuthApi.resend_otp, params: input) { (result: ResendOtpBase?, message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    
    func requestOtpVerification(input: Parameters, handler: @escaping (_ result: ResendOtpBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: AuthApi.cus_otpverification, params: input) { (result: ResendOtpBase?, message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    
}
