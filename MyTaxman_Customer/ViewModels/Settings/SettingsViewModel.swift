//
//  SettingsViewModel.swift
//  MyTaxman_Customer
//
//  Created by Vanithasree Rajeshkumar on 21/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
class SettingsViewModel {
    
    func getCustProfileDetails(input: Parameters, handler: @escaping (_ user: CustomerProfileBase?, _ error: AlertMessage?)->()) {
        SettingsApiManager().getCustomerProfile(input: input, handler: handler)
    }
    func editCustomerProfileDetails(input: Parameters, handler: @escaping (_ user: EditProfileBase?, _ error: AlertMessage?)->()) {
        SettingsApiManager().editCustomerProfile(input: input, handler: handler)
        
    }
    func changeCusPasswordCredentials(input: Parameters, handler: @escaping (_ user: ChangePasswordBase?, _ error: AlertMessage?)->()) {
        SettingsApiManager().changeCustomerPassword(input: input, handler: handler)
    }
}
