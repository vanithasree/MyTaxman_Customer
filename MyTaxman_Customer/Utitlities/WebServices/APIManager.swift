//
//  APIManager.swift
//  jps
//
//  Created by vijaykarthik on 15/04/20.
//  Copyright © 2020 vijaykarthik. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkEnvironment {
    case dev
    case production
    case stage
}

protocol EndPointType {
    
    //MARK: vars and lets
    var baseURL : String { get }
    var path : String { get }
    var httpMethod : HTTPMethod  { get }
    var url : URL { get }
    var encoding : ParameterEncoding { get }
    var version : String { get }
}

extension EndPointType {
    //Mark: - vars and lets
    
    var baseURL : String {
        switch APIManager.networkEnviroment {
        case .dev: return Constant.devURLBaseString //Config url here
        case .production : return ""
        case .stage : return ""
        }
    }
    
    var version : String {
        return "/v0_1"
    }
    
    var headers: HTTPHeaders? {
        if UserDetails.shared.isLoggedIn {
            return UserDetails.shared.isLoggedIn ? .init(["Authorization":"Bearer \(UserDetails.shared.accessToken)"]) : [ "Content-Type": "application/json",
                                                                                                                           "X-Requested-With": "XMLHttpRequest",
                                                                                                                           "x-access-token": "someToken" ]
        }
        
        return nil
    }
    
    var url : URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.path)!
        }
    }
    
    var encoding : ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
}

class AlertMessage {
    var statusCode : Int = 0
    var errorMessage : String = ""
    
    /*private func parseApiError(data: Data?) -> AlertMessage {
     let decoder = JSONDecoder()
     if let jsonData = data, let error = try? decoder.decode(ErrorObject.self, from: jsonData) {
     //return AlertMessage(title: "Test", body: error.key?.localized() ?? error.message)
     
     }
     return AlertMessage(title: Constants.errorAlertTitle.localized(), body: Constants.genericErrorMessage)
     }*/
}

class ErrorObject: Codable {
    
    let message: String
    let key: String?
    
}


class APIManager {
    
    private let sessionManager: Session
    static let networkEnviroment: NetworkEnvironment = .dev
    
    // MARK: - Vars & Lets
    
    private static var sharedApiManager: APIManager = {
        let apiManager = APIManager(sessionManager: Session())
        
        return apiManager
    }()
    
    // MARK: - Accessors
    
    class func shared() -> APIManager {
        return sharedApiManager
    }
    
    // MARK: - Initialization
    
    private init(sessionManager: Session) {
        self.sessionManager = sessionManager
    }
    
    func call<T>(type: EndPointType, urlParams: String = "", handler: @escaping (T?, _ error: AlertMessage?)->()) where T: Codable {
        
        let customUrl = type.url.absoluteString
        let encodeURL : String = (customUrl + urlParams).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = URL(string: encodeURL)!
        
        print("url:", url)
        print("method:", type.httpMethod)
        print("Header", type.headers ?? "")
        
        self.sessionManager.request(url,
                                    method: type.httpMethod,
                                    parameters: nil,
                                    encoding: type.encoding,
                                    headers: type.headers).validate().responseJSON { data in
                                        switch data.result {
                                        case .success(_):
                                            let decoder = JSONDecoder()
                                            if let jsonData = data.data {
                                                do {
                                                    let jsonDict = try JSONSerialization.jsonObject(with: jsonData) as? NSDictionary
//                                                    print("Response:", jsonDict ?? [:])
                                                    self.jsonToString(json: jsonDict ?? [:])

                                                    let result = try decoder.decode(T.self, from: jsonData)
                                                    handler(result, nil)
                                                } catch let error {
                                                    print("Error:", error.localizedDescription)
                                                    handler(nil, ErrorMessage(message: error.localizedDescription, status: 0))
                                                }
                                            }
                                            break
                                        case .failure(let error):
                                            switch error.responseCode {
                                                
                                            case 401:
                                                self.callLogoutAndRedirectToWelcomeScreen()
                                                break
                                                
                                                //                case 400, 404:
                                                //                    self.showAlert()
                                                //                    break
                                                
                                            default:
                                                let decoder = JSONDecoder()
                                                if let jsonData = data.data {
                                                    do {
                                                        
                                                        let jsonDict = try JSONSerialization.jsonObject(with: jsonData) as? NSDictionary
//                                                        print("Response:", jsonDict ?? [:])
                                                        self.jsonToString(json: jsonDict ?? [:])

                                                        let result = try decoder.decode(T.self, from: jsonData)
                                                        handler(result, nil)
                                                    } catch let error {
                                                        handler(nil, ErrorMessage(message: error.localizedDescription, status: 0))
                                                    }
                                                }else {
                                                    handler(nil, ErrorMessage(message: error.localizedDescription, status: 0))
                                                }
                                                
                                                break
                                                
                                            }
                                            //                                            handler(nil, ErrorMessage(message: error.localizedDescription, status: error.responseCode ?? 0))
                                            //                                             handler(nil, self.parseApiError(data: data.data))
                                            //                                            break
                                        }
        }
    }
    
    func call<T>(type: EndPointType,
                 urlInput: String,
                 params: Array<Any>? = nil,
                 handler: @escaping (T?, _ error: AlertMessage?)->()) where T: Codable {
        
        let customUrl = type.url.absoluteString
        
        let encodeURL : String = (customUrl + urlInput).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = URL(string: encodeURL)!
        
        print("url:", url)
        print("method:", type.httpMethod.rawValue)
        print("Header", type.headers ?? "")
        print("Params", params ?? [])
        
        var request = URLRequest(url: url)
        request.httpMethod = type.httpMethod.rawValue
        type.headers?.dictionary.forEach({ (arg0) in
            let (key, value) = arg0
            request.setValue(value, forHTTPHeaderField: key)
        })
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let values = params?.description ?? ""
        
        request.httpBody = values.data(using: .utf8)
        
        AF.request(request).responseJSON { data in
            switch data.result {
            case .success(_):
                
                //                switch data.response?.statusCode {
                //                case 200, 400, 404:
                let decoder = JSONDecoder()
                if let jsonData = data.data {
                    do {
                        
                        let jsonDict = try JSONSerialization.jsonObject(with: jsonData) as? NSDictionary
//                        print("Response:", jsonDict ?? [:])
                        self.jsonToString(json: jsonDict ?? [:])

                        let result = try decoder.decode(T.self, from: jsonData)
                        handler(result, nil)
                    } catch let error {
                        handler(nil, ErrorMessage(message: error.localizedDescription, status: 0))
                    }
                }
                break
                
                //                case 401:
                //                    break
                //                    //                case 400, 404:
                //                    //                    self.showAlert()
                //                    //                    break
                //
                //                default:
                //                    break
                //                }
                
            case .failure(let error):
                
                switch error.responseCode {
                    
                case 401:
                    self.callLogoutAndRedirectToWelcomeScreen()
                    break
                    
                    //                case 400, 404:
                    //                    self.showAlert()
                    //                    break
                    
                default:
                    let decoder = JSONDecoder()
                    if let jsonData = data.data {
                        do {
                            
                            let jsonDict = try JSONSerialization.jsonObject(with: jsonData) as? NSDictionary
//                            print("Response:", jsonDict ?? [:])
                            self.jsonToString(json: jsonDict ?? [:])
                            
                            let result = try decoder.decode(T.self, from: jsonData)
                            handler(result, nil)
                        } catch let error {
                            handler(nil, ErrorMessage(message: error.localizedDescription, status: 0))
                        }
                    }else {
                        handler(nil, ErrorMessage(message: error.localizedDescription, status: 0))
                    }
                    
                    break
                    
                }
                
                
                //                handler(nil, ErrorMessage(message: error.localizedDescription, status: error.responseCode ?? 0))
                //                //                                             handler(nil, self.parseApiError(data: data.data))
                //                break
            }
        }
        
    }
    
    func call<T>(type: EndPointType, params: Parameters? = nil, handler: @escaping (T?, _ error: AlertMessage?)->()) where T: Codable {
        
        print("url:", type.url)
        print("method:", type.httpMethod)
        print("param:", params ?? [:])
        
        print("Header", type.headers ?? [:])
        
        self.sessionManager.request(type.url,
                                    method: type.httpMethod,
                                    parameters: params,
                                    encoding: type.encoding,
                                    headers: type.headers).validate().responseJSON { data in
                                        switch data.result {
                                        case .success(_):
                                            
                                            //                                            switch data.response?.statusCode {
                                            //                                            case 200, 400, 404:
                                            let decoder = JSONDecoder()
                                            if let jsonData = data.data {
                                                do {
                                                    
                                                    let jsonDict = try JSONSerialization.jsonObject(with: jsonData) as? NSDictionary
//                                                    print("Response:", jsonDict ?? [:])
                                                    self.jsonToString(json: jsonDict ?? [:])

                                                    let result = try decoder.decode(T.self, from: jsonData)
                                                    handler(result, nil)
                                                } catch let error {
                                                    handler(nil, ErrorMessage(message: error.localizedDescription, status: 0))
                                                }
                                            }
                                            //                                                break
                                            
                                            //                                            case 400, 404:
                                            //                                                self.showAlert()
                                            //                                                break
                                            
                                            //                                            default:
                                            //                                                break
                                            //                                            }
                                            
                                        case .failure(let error):
                                            
                                            switch error.responseCode {
                                                
                                            case 401:
                                                self.callLogoutAndRedirectToWelcomeScreen()
                                                break
                                                
                                                //                                            case 400, 404:
                                                //                                                self.showAlert()
                                                //                                                break
                                                
                                            default:
                                                let decoder = JSONDecoder()
                                                if let jsonData = data.data {
                                                    do {
                                                        
                                                        let jsonDict = try JSONSerialization.jsonObject(with: jsonData) as? NSDictionary
//                                                        print("Response:", jsonDict ?? [:])
                                                        self.jsonToString(json: jsonDict ?? [:])

                                                        let result = try decoder.decode(T.self, from: jsonData)
                                                        handler(result, nil)
                                                    } catch let error {
                                                        handler(nil, ErrorMessage(message: error.localizedDescription, status: 0))
                                                    }
                                                }else {
                                                    handler(nil, ErrorMessage(message: error.localizedDescription, status: 0))
                                                }
                                                break
                                                
                                            }
                                            
                                            
                                            //                                            handler(nil, ErrorMessage(message: error.localizedDescription, status: error.responseCode ?? 0))
                                            //                                            //                                             handler(nil, self.parseApiError(data: data.data))
                                            //                                            break
                                        }
        }
    }
    
    func uploadDocument<T>(type: EndPointType, params: Dictionary<String, String>,fileUrl:URL?, fileName:String, handler: @escaping (T?, _ error: AlertMessage?)->()) where T: Codable {
        AF.upload(
            multipartFormData: { multipartFormData in
                
                
                multipartFormData.append(fileUrl!, withName:"Upload" )
                
                for (key, value) in params {
                    
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
                
        },
            to: type.url, method: type.httpMethod , headers: type.headers)
            .response { data in
                switch data.result {
                case .success(_):
                    
                    //                    switch data.response?.statusCode {
                    //                    case 200, 400, 404:
                    let decoder = JSONDecoder()
                    if let jsonData = data.data {
                        do {
                            
                            let jsonDict = try JSONSerialization.jsonObject(with: jsonData) as? NSDictionary
//                            print("Response:", jsonDict ?? [:])
                            self.jsonToString(json: jsonDict ?? [:])
                            
                            let result = try decoder.decode(T.self, from: jsonData)
                            handler(result, nil)
                        } catch let error {
                            handler(nil, ErrorMessage(message: error.localizedDescription, status: 0))
                        }
                    }
                    //                        break
                    //                    case 401:
                    //                        self.callLogoutAndRedirectToWelcomeScreen()
                    //                        break
                    //
                    ////                    case 400, 404:
                    ////                        self.showAlert()
                    ////                        break
                    //
                    //                    default:
                    //                        break
                    //                    }
                    
                case .failure(let error):
                    
                    switch error.responseCode {
                        
                    case 401:
                        self.callLogoutAndRedirectToWelcomeScreen()
                        break
                        
                        //                    case 404:
                        //                        self.showAlert()
                        //                        break
                        //
                        //                    case 500:
                        //                        break
                        
                    default:
                        let decoder = JSONDecoder()
                        if let jsonData = data.data {
                            do {
                                
                                let jsonDict = try JSONSerialization.jsonObject(with: jsonData) as? NSDictionary
//                                print("Response:", jsonDict ?? [:])
                                self.jsonToString(json: jsonDict ?? [:])
                                
                                
                                let result = try decoder.decode(T.self, from: jsonData)
                                handler(result, nil)
                            } catch let error {
                                handler(nil, ErrorMessage(message: error.localizedDescription, status: 0))
                            }
                        }else {
                            handler(nil, ErrorMessage(message: error.localizedDescription, status: 0))
                        }
                        break
                        
                    }
                    
                    
                    //handler(nil, ErrorMessage(message: error.localizedDescription, status: error.responseCode ?? 0))
                    //                                             handler(nil, self.parseApiError(data: data.data))
                    //                    break
                }
        }
    }
    
    
    
    func showAlert() {
        let alertController = UIAlertController(title: "title", message: "message", preferredStyle: .alert)
        //...
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        if let tabBarController = rootViewController as? UITabBarController {
            rootViewController = tabBarController.selectedViewController
        }
        //...
        rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func callLogoutAndRedirectToWelcomeScreen() {
        UserDetails.shared.logout()
        doOnMain {
            let welcomeVC = GetStartedViewController.instantiateFromAppStoryboard(appStoryboard: .Auth)
            let navigatinC = UINavigationController(rootViewController: welcomeVC)
            UIApplication.shared.windows.first?.rootViewController = navigatinC
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
    
    func jsonToString(json: AnyObject){
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            print(convertedString ?? "") // <-- here is ur string

        } catch let myJSONError {
            print(myJSONError)
        }

    }
}


class ErrorMessage: AlertMessage {
    
    init(message: String, status: Int) {
        super.init()
        
        self.errorMessage = message
        self.statusCode = status
    }
}
