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
    
    func getCustomerTaskListForActiveTab(input: Parameters, handler: @escaping (_ user: CustTaskListBase?, _ error: AlertMessage?)->()) {
        LeadApiManager().getCusTaskList(input: input, handler: handler)
    }
    
    func getCustomerTaskListForCompletedTab(input: Parameters, handler: @escaping (_ user: CompletedTaskListBase?, _ error: AlertMessage?)->()) {
        LeadApiManager().getCusCompletedTaskList(input: input, handler: handler)
    }
    
    func getCustomerTaskListForClosedTab(input: Parameters, handler: @escaping (_ user: ClosedJobListBase?, _ error: AlertMessage?)->()) {
        LeadApiManager().getCusClosedTaskList(input: input, handler: handler)
    }
    func editJobDesc(input: Parameters, handler: @escaping (_ user: EditDescriptionBase?, _ error: AlertMessage?)->()) {
        LeadApiManager().editTaskDescription(input: input, handler: handler)
    }
    func cancelCustomerTask(input: Parameters, handler: @escaping (_ user: ChangePasswordBase?, _ error: AlertMessage?)->()) {
        LeadApiManager().cancelTask(input: input, handler: handler)
    }
    func hireVendorTechnician(input: Parameters, handler: @escaping (_ user: ChangePasswordBase?, _ error: AlertMessage?)->()) {
        LeadApiManager().hireTechnician(input: input, handler: handler)
    }
    
    func customerReviewSubmit(input: Parameters, handler: @escaping (_ user: SubmitReviewBase?, _ error: AlertMessage?)->()) {
        LeadApiManager().customerReviewSubmit(input: input, handler: handler)
    }
    func getTaskDetailList(input: Parameters, handler: @escaping (_ user: CustomerJobDetailBase?, _ error: AlertMessage?)->()) {
        LeadApiManager().getTaskDetail(input: input, handler: handler)
    }
}



