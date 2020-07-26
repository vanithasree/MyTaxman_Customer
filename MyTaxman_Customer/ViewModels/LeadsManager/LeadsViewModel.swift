//
//  LeadsViewModel.swift
//  MyTaxman_Customer
//
//  Created by Apple on 26/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class LeadViewModel {
    //
    func postTheTaskBeforeCustomerLogin(input: Parameters, handler: @escaping (_ user: PostJobBaseForNewCustomer?, _ error: AlertMessage?)->()) {
        LeadApiManager().postTaskBeforeLogin(input: input, handler: handler)
    }
    func postTaskLoggedInCustomer(input: Parameters, handler: @escaping (_ user: PostJobForLoggedInCustomer?, _ error: AlertMessage?)->()) {
        LeadApiManager().postTaskForLoggedInCustomer(input: input, handler: handler)
    }
}


