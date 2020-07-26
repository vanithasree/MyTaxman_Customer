//
//  LeadsManager.swift
//  MyTaxman_Customer
//
//  Created by Apple on 22/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

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

class LeadsManager {
    static let shared = LeadsManager()
    
    var choosenService : ServiceListKeys = .taxReturns
    
    
    
    private init() {
        
    }
}
