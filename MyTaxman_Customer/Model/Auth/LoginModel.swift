//
//  LoginModel.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 23/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
struct LoginBase : Codable {
    let isSuccessful : Bool?
    let statusCode : String?
    let responseStatus : String?
    
    enum CodingKeys: String, CodingKey {
        
        case isSuccessful = "isSuccessful"
        case statusCode = "statusCode"
        case responseStatus = "responseStatus"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isSuccessful = try values.decodeIfPresent(Bool.self, forKey: .isSuccessful)
        statusCode = try values.decodeIfPresent(String.self, forKey: .statusCode)
        responseStatus = try values.decodeIfPresent(String.self, forKey: .responseStatus)
    }
    
}
