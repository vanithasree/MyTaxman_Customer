//
//  JobsModel.swift
//  MyTaxman_Customer
//
//  Created by Apple on 26/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation


struct ServicesList {
    var imageName : String
    var title : String
}
enum ContactInfo : Int {
    case isFromRegisterAccount = 1
    case isFromJob = 2
}

enum ServiceListKeys : String {
    case taxReturns = "Tax Returns"
    case accounting = "Accounting"
    case financialPlanning = "Financial Planning"
    case superFunds = "Super Funds"
    case audit = "Audit"
    case legalAdvice = "Legal Advice"
}

struct JobsParams : Codable {
    var customername : String?
    var email : String?
    var mobile : String?
    var password : String?
    var deviceid : String?
    var device_currentdatetime : String?
    var category : String?
    var page1 : String?
    var page2 : String?
    var page3 : String?
    var page4 : String?
    var page5 : String?
    var page6 : String?
    var page7 : String?
    var device_token : String?
    var description : String?
    var service_location : String?
    var lattitude : Double?
    var longtitude : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case customername = "customername"
        case email = "email"
        case mobile = "mobile"
        case password = "password"
        case deviceid = "deviceid"
        case device_currentdatetime = "device_currentdatetime"
        case category = "category"
        case page1 = "page1"
        case page2 = "page2"
        case page3 = "page3"
        case page4 = "page4"
        case page5 = "page5"
        case page6 = "page6"
        case page7 = "page7"
        case device_token = "device_token"
        case description = "description"
        case service_location = "service_location"
        case lattitude = "lattitude"
        case longtitude = "longtitude"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        customername = try values.decodeIfPresent(String.self, forKey: .customername)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        deviceid = try values.decodeIfPresent(String.self, forKey: .deviceid)
        device_currentdatetime = try values.decodeIfPresent(String.self, forKey: .device_currentdatetime)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        page1 = try values.decodeIfPresent(String.self, forKey: .page1)
        page2 = try values.decodeIfPresent(String.self, forKey: .page2)
        page3 = try values.decodeIfPresent(String.self, forKey: .page3)
        page4 = try values.decodeIfPresent(String.self, forKey: .page4)
        page5 = try values.decodeIfPresent(String.self, forKey: .page5)
        page6 = try values.decodeIfPresent(String.self, forKey: .page6)
        page7 = try values.decodeIfPresent(String.self, forKey: .page7)
        device_token = try values.decodeIfPresent(String.self, forKey: .device_token)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        service_location = try values.decodeIfPresent(String.self, forKey: .service_location)
        lattitude = try values.decodeIfPresent(Double.self, forKey: .lattitude)
        longtitude = try values.decodeIfPresent(Double.self, forKey: .longtitude)
    }
    
}
