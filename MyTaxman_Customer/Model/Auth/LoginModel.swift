//
//  LoginModel.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 23/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
struct LoginBase : Codable {
    let desc : String?
    let code : String?
    
    enum CodingKeys: String, CodingKey {
        
        case desc = "desc"
        case code = "code"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
        code = try values.decodeIfPresent(String.self, forKey: .code)
    }
    
}
