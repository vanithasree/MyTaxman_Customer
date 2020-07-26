//
//  LeadsManager.swift
//  MyTaxman_Customer
//
//  Created by Apple on 22/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit


class LeadsManager {
    static let shared = LeadsManager()
    
    var choosenService : ServiceListKeys = .taxReturns
    var postJobsParams: JobsParams?

    
    private init() {
        
    }
}
