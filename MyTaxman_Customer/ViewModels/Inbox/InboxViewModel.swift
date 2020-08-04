//
//  InboxViewModel.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 04/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
class InboxViewModel {
    
    func requestCusinboxlist(input: Parameters, handler: @escaping (_ user: InboxListBase?, _ error: AlertMessage?)->()) {
        InboxApiManager().requestCusinboxlist(input: input, handler: handler)
    }
    
    func requestChat(input: Parameters, handler: @escaping (_ user: ChatBase?, _ error: AlertMessage?)->()) {
        InboxApiManager().requestChat(input: input, handler: handler)
    }
    
    func requestSendChat(input: Parameters, handler: @escaping (_ user: SendChatBase?, _ error: AlertMessage?)->()) {
        InboxApiManager().requestSendChat(input: input, handler: handler)
    }
    
    func requestVenProfile(input: Parameters, handler: @escaping (_ user: CheckMobile_Base?, _ error: AlertMessage?)->()) {
        InboxApiManager().requestVenProfile(input: input, handler: handler)
    }
    
    func requestHireTechnician(input: Parameters, handler: @escaping (_ user: ResendOtpBase?, _ error: AlertMessage?)->()) {
        InboxApiManager().requestHireTechnician(input: input, handler: handler)
    }
    
    func requestVen_quote_decline_bycustomer(input: Parameters, handler: @escaping (_ user: OtpVerifyBase?, _ error: AlertMessage?)->()) {
        InboxApiManager().requestVen_quote_decline_bycustomer(input: input, handler: handler)
    }

}
extension InboxViewModel {
    
    func validateMessage(text: String) -> ValidationMessage {
        if text.isEmpty || text.isBlank {
            return (ValidationMessage(status: false, errorMessage: messgeRequired, tag:0))
        }
        return (ValidationMessage(status: true, errorMessage: "", tag:0))
    }
}
