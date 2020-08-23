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
    var customerid : String?
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
        
        
        case customerid = "customerid"
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
    /*{"customerid" : "124","device_currentdatetime":"2020-07-21 18:09:50","category":"Legal Advice","page1":"Corporate Law","page2":null,"page3":null,"page4":null,"page5":null,"page6":"Correspondence","page7":null,"device_token":"fy4SDMkHQYaTTdCdbcbMiW:APA91bFb0NOH9QCkMuvuqYKeiE8eFW17UNT2HMXEpZ_wzykJdhVfHWFJUug0h9iria8p5dqJ-YsIwafXAJGmOxKvwpNnraz5cN_hkyyUlLjLy4EXxN9faZGJ09MgN8wZtnmH-40pnIzF","description":null,"service_location":"Coventry Street, South Melbourne VIC","lattitude":-37.8320111,"longtitude":144.9559391}*/
    
    
    var toJSONForNewCustomer : [String : Any] {
        return ["customerid" : customerid ?? "",
                "device_currentdatetime": device_currentdatetime ?? "",
                "category" : category ?? "",
                "page1": page1 ?? "",
                "page2" : page2 ?? "",
                "page3" : page3 ?? "",
                "page4": page4 ?? "",
                "page5" : page5 ?? "",
                "page6": page6 ?? "",
                "page7": page7 ?? "",
                "device_token" : device_token ?? "",
                "description": description ?? "",
                "service_location": service_location ?? "",
                "lattitude" : lattitude,
                "longtitude": longtitude
        ]
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        customerid = try values.decodeIfPresent(String.self, forKey: .customerid)
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
struct PostJobBaseForNewCustomer : Codable {
    let code : String?
    let new_customer : [New_customer]?
    let task : [Task]?
    
    enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case new_customer = "new_customer"
        case task = "task"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        new_customer = try values.decodeIfPresent([New_customer].self, forKey: .new_customer)
        task = try values.decodeIfPresent([Task].self, forKey: .task)
    }
    
}
struct Task : Codable {
    let taskid : String?
    let customerid : String?
    let category : String?
    let page1_title : String?
    let page1 : String?
    let page2_title : String?
    let page2 : String?
    let page3_title : String?
    let page3 : String?
    let page4_title : String?
    let page4 : String?
    let page5_title : String?
    let page5 : String?
    let page6_title : String?
    let page6 : String?
    let page7_title : String?
    let page7 : String?
    let description : String?
    let task_credits : String?
    let service_location : String?
    let lattitude : String?
    let longtitude : String?
    let task_status : String?
    let task_completed_on : String?
    let task_cancel_status : String?
    let cancel_description : String?
    let task_cancel_on : String?
    let task_submitted_on : String?
    let vendor_review : String?
    let vendor_review_givenon : String?
    let cus_callid : String?
    let customername : String?
    let email : String?
    let mobile : String?
    let password : String?
    let otp : String?
    let otp_verified : String?
    let city : String?
    let postalcode : String?
    let deviceid : String?
    let device_token : String?
    let registeredon : String?
    let profile_updated_on : String?
    let password_updated_on : String?
    let newsletter_notification : String?
    let newmessage_notification : String?
    let from_time : String?
    let to_time : String?
    let time_zone : String?
    
    enum CodingKeys: String, CodingKey {
        
        case taskid = "taskid"
        case customerid = "customerid"
        case category = "category"
        case page1_title = "page1_title"
        case page1 = "page1"
        case page2_title = "page2_title"
        case page2 = "page2"
        case page3_title = "page3_title"
        case page3 = "page3"
        case page4_title = "page4_title"
        case page4 = "page4"
        case page5_title = "page5_title"
        case page5 = "page5"
        case page6_title = "page6_title"
        case page6 = "page6"
        case page7_title = "page7_title"
        case page7 = "page7"
        case description = "description"
        case task_credits = "task_credits"
        case service_location = "service_location"
        case lattitude = "lattitude"
        case longtitude = "longtitude"
        case task_status = "task_status"
        case task_completed_on = "task_completed_on"
        case task_cancel_status = "task_cancel_status"
        case cancel_description = "cancel_description"
        case task_cancel_on = "task_cancel_on"
        case task_submitted_on = "task_submitted_on"
        case vendor_review = "vendor_review"
        case vendor_review_givenon = "vendor_review_givenon"
        case cus_callid = "cus_callid"
        case customername = "customername"
        case email = "email"
        case mobile = "mobile"
        case password = "password"
        case otp = "otp"
        case otp_verified = "otp_verified"
        case city = "city"
        case postalcode = "postalcode"
        case deviceid = "deviceid"
        case device_token = "device_token"
        case registeredon = "registeredon"
        case profile_updated_on = "profile_updated_on"
        case password_updated_on = "password_updated_on"
        case newsletter_notification = "newsletter_notification"
        case newmessage_notification = "newmessage_notification"
        case from_time = "from_time"
        case to_time = "to_time"
        case time_zone = "time_zone"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        taskid = try values.decodeIfPresent(String.self, forKey: .taskid)
        customerid = try values.decodeIfPresent(String.self, forKey: .customerid)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        page1_title = try values.decodeIfPresent(String.self, forKey: .page1_title)
        page1 = try values.decodeIfPresent(String.self, forKey: .page1)
        page2_title = try values.decodeIfPresent(String.self, forKey: .page2_title)
        page2 = try values.decodeIfPresent(String.self, forKey: .page2)
        page3_title = try values.decodeIfPresent(String.self, forKey: .page3_title)
        page3 = try values.decodeIfPresent(String.self, forKey: .page3)
        page4_title = try values.decodeIfPresent(String.self, forKey: .page4_title)
        page4 = try values.decodeIfPresent(String.self, forKey: .page4)
        page5_title = try values.decodeIfPresent(String.self, forKey: .page5_title)
        page5 = try values.decodeIfPresent(String.self, forKey: .page5)
        page6_title = try values.decodeIfPresent(String.self, forKey: .page6_title)
        page6 = try values.decodeIfPresent(String.self, forKey: .page6)
        page7_title = try values.decodeIfPresent(String.self, forKey: .page7_title)
        page7 = try values.decodeIfPresent(String.self, forKey: .page7)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        task_credits = try values.decodeIfPresent(String.self, forKey: .task_credits)
        service_location = try values.decodeIfPresent(String.self, forKey: .service_location)
        lattitude = try values.decodeIfPresent(String.self, forKey: .lattitude)
        longtitude = try values.decodeIfPresent(String.self, forKey: .longtitude)
        task_status = try values.decodeIfPresent(String.self, forKey: .task_status)
        task_completed_on = try values.decodeIfPresent(String.self, forKey: .task_completed_on)
        task_cancel_status = try values.decodeIfPresent(String.self, forKey: .task_cancel_status)
        cancel_description = try values.decodeIfPresent(String.self, forKey: .cancel_description)
        task_cancel_on = try values.decodeIfPresent(String.self, forKey: .task_cancel_on)
        task_submitted_on = try values.decodeIfPresent(String.self, forKey: .task_submitted_on)
        vendor_review = try values.decodeIfPresent(String.self, forKey: .vendor_review)
        vendor_review_givenon = try values.decodeIfPresent(String.self, forKey: .vendor_review_givenon)
        cus_callid = try values.decodeIfPresent(String.self, forKey: .cus_callid)
        customername = try values.decodeIfPresent(String.self, forKey: .customername)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        otp = try values.decodeIfPresent(String.self, forKey: .otp)
        otp_verified = try values.decodeIfPresent(String.self, forKey: .otp_verified)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        postalcode = try values.decodeIfPresent(String.self, forKey: .postalcode)
        deviceid = try values.decodeIfPresent(String.self, forKey: .deviceid)
        device_token = try values.decodeIfPresent(String.self, forKey: .device_token)
        registeredon = try values.decodeIfPresent(String.self, forKey: .registeredon)
        profile_updated_on = try values.decodeIfPresent(String.self, forKey: .profile_updated_on)
        password_updated_on = try values.decodeIfPresent(String.self, forKey: .password_updated_on)
        newsletter_notification = try values.decodeIfPresent(String.self, forKey: .newsletter_notification)
        newmessage_notification = try values.decodeIfPresent(String.self, forKey: .newmessage_notification)
        from_time = try values.decodeIfPresent(String.self, forKey: .from_time)
        to_time = try values.decodeIfPresent(String.self, forKey: .to_time)
        time_zone = try values.decodeIfPresent(String.self, forKey: .time_zone)
    }
    
}

struct New_customer : Codable {
    let customerid : String?
    let cus_callid : String?
    let customername : String?
    let email : String?
    let mobile : String?
    let password : String?
    let otp : String?
    let otp_verified : String?
    let city : String?
    let postalcode : String?
    let deviceid : String?
    let device_token : String?
    let registeredon : String?
    let profile_updated_on : String?
    let password_updated_on : String?
    let newsletter_notification : String?
    let newmessage_notification : String?
    let from_time : String?
    let to_time : String?
    let time_zone : String?
    
    enum CodingKeys: String, CodingKey {
        
        case customerid = "customerid"
        case cus_callid = "cus_callid"
        case customername = "customername"
        case email = "email"
        case mobile = "mobile"
        case password = "password"
        case otp = "otp"
        case otp_verified = "otp_verified"
        case city = "city"
        case postalcode = "postalcode"
        case deviceid = "deviceid"
        case device_token = "device_token"
        case registeredon = "registeredon"
        case profile_updated_on = "profile_updated_on"
        case password_updated_on = "password_updated_on"
        case newsletter_notification = "newsletter_notification"
        case newmessage_notification = "newmessage_notification"
        case from_time = "from_time"
        case to_time = "to_time"
        case time_zone = "time_zone"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        customerid = try values.decodeIfPresent(String.self, forKey: .customerid)
        cus_callid = try values.decodeIfPresent(String.self, forKey: .cus_callid)
        customername = try values.decodeIfPresent(String.self, forKey: .customername)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        otp = try values.decodeIfPresent(String.self, forKey: .otp)
        otp_verified = try values.decodeIfPresent(String.self, forKey: .otp_verified)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        postalcode = try values.decodeIfPresent(String.self, forKey: .postalcode)
        deviceid = try values.decodeIfPresent(String.self, forKey: .deviceid)
        device_token = try values.decodeIfPresent(String.self, forKey: .device_token)
        registeredon = try values.decodeIfPresent(String.self, forKey: .registeredon)
        profile_updated_on = try values.decodeIfPresent(String.self, forKey: .profile_updated_on)
        password_updated_on = try values.decodeIfPresent(String.self, forKey: .password_updated_on)
        newsletter_notification = try values.decodeIfPresent(String.self, forKey: .newsletter_notification)
        newmessage_notification = try values.decodeIfPresent(String.self, forKey: .newmessage_notification)
        from_time = try values.decodeIfPresent(String.self, forKey: .from_time)
        to_time = try values.decodeIfPresent(String.self, forKey: .to_time)
        time_zone = try values.decodeIfPresent(String.self, forKey: .time_zone)
    }
    
}


struct PostJobForLoggedInCustomer : Codable {
    let code : String?
    let customerid : String?
    let customer_tasks : [Customer_tasks]?
    let tasks_quotes_details : [Tasks_quotes_details]?
    let quotes : [QuotesForTask]?
    let desc : String?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case customerid = "customerid"
        case customer_tasks = "customer_tasks"
        case tasks_quotes_details = "Tasks_quotes_details"
        case quotes = "quotes"
        case desc = "desc"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        customerid = try values.decodeIfPresent(String.self, forKey: .customerid)
        customer_tasks = try values.decodeIfPresent([Customer_tasks].self, forKey: .customer_tasks)
        tasks_quotes_details = try values.decodeIfPresent([Tasks_quotes_details].self, forKey: .tasks_quotes_details)
        quotes = try values.decodeIfPresent([QuotesForTask].self, forKey: .quotes)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
    }

}
struct Customer_tasks : Codable {
    let page6 : String?
    let taskid : String?
    let page4_title : String?
    let description : String?
    let task_credits : String?
    let longtitude : String?
    let task_submitted_on : String?
    let page5 : String?
    let page5_title : String?
    let task_cancel_status : String?
    let customerid : String?
    let category : String?
    let page4 : String?
    let page6_title : String?
    let page1_title : String?
    let task_completed_on : String?
    let vendor_review_givenon : String?
    let page3 : String?
    let page7_title : String?
    let page2_title : String?
    let vendor_review : String?
    let cancel_description : String?
    let task_status : String?
    let page2 : String?
    let page7 : String?
    let page3_title : String?
    let lattitude : String?
    let task_cancel_on : String?
    let service_location : String?
    let page1 : String?

    enum CodingKeys: String, CodingKey {

        case page6 = "page6"
        case taskid = "taskid"
        case page4_title = "page4_title"
        case description = "description"
        case task_credits = "task_credits"
        case longtitude = "longtitude"
        case task_submitted_on = "task_submitted_on"
        case page5 = "page5"
        case page5_title = "page5_title"
        case task_cancel_status = "task_cancel_status"
        case customerid = "customerid"
        case category = "category"
        case page4 = "page4"
        case page6_title = "page6_title"
        case page1_title = "page1_title"
        case task_completed_on = "task_completed_on"
        case vendor_review_givenon = "vendor_review_givenon"
        case page3 = "page3"
        case page7_title = "page7_title"
        case page2_title = "page2_title"
        case vendor_review = "vendor_review"
        case cancel_description = "cancel_description"
        case task_status = "task_status"
        case page2 = "page2"
        case page7 = "page7"
        case page3_title = "page3_title"
        case lattitude = "lattitude"
        case task_cancel_on = "task_cancel_on"
        case service_location = "service_location"
        case page1 = "page1"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page6 = try values.decodeIfPresent(String.self, forKey: .page6)
        taskid = try values.decodeIfPresent(String.self, forKey: .taskid)
        page4_title = try values.decodeIfPresent(String.self, forKey: .page4_title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        task_credits = try values.decodeIfPresent(String.self, forKey: .task_credits)
        longtitude = try values.decodeIfPresent(String.self, forKey: .longtitude)
        task_submitted_on = try values.decodeIfPresent(String.self, forKey: .task_submitted_on)
        page5 = try values.decodeIfPresent(String.self, forKey: .page5)
        page5_title = try values.decodeIfPresent(String.self, forKey: .page5_title)
        task_cancel_status = try values.decodeIfPresent(String.self, forKey: .task_cancel_status)
        customerid = try values.decodeIfPresent(String.self, forKey: .customerid)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        page4 = try values.decodeIfPresent(String.self, forKey: .page4)
        page6_title = try values.decodeIfPresent(String.self, forKey: .page6_title)
        page1_title = try values.decodeIfPresent(String.self, forKey: .page1_title)
        task_completed_on = try values.decodeIfPresent(String.self, forKey: .task_completed_on)
        vendor_review_givenon = try values.decodeIfPresent(String.self, forKey: .vendor_review_givenon)
        page3 = try values.decodeIfPresent(String.self, forKey: .page3)
        page7_title = try values.decodeIfPresent(String.self, forKey: .page7_title)
        page2_title = try values.decodeIfPresent(String.self, forKey: .page2_title)
        vendor_review = try values.decodeIfPresent(String.self, forKey: .vendor_review)
        cancel_description = try values.decodeIfPresent(String.self, forKey: .cancel_description)
        task_status = try values.decodeIfPresent(String.self, forKey: .task_status)
        page2 = try values.decodeIfPresent(String.self, forKey: .page2)
        page7 = try values.decodeIfPresent(String.self, forKey: .page7)
        page3_title = try values.decodeIfPresent(String.self, forKey: .page3_title)
        lattitude = try values.decodeIfPresent(String.self, forKey: .lattitude)
        task_cancel_on = try values.decodeIfPresent(String.self, forKey: .task_cancel_on)
        service_location = try values.decodeIfPresent(String.self, forKey: .service_location)
        page1 = try values.decodeIfPresent(String.self, forKey: .page1)
    }

}

struct Tasks_quotes_details : Codable {
    let received_quotes : String?
  /*  let taskid : String?
    let customerid : String?
    let category : String?
    let page1_title : String?
    let page1 : String?
    let page2_title : String?
    let page2 : String?
    let page3_title : String?
    let page3 : String?
    let page4_title : String?
    let page4 : String?
    let page5_title : String?
    let page5 : String?
    let page6_title : String?
    let page6 : String?
    let page7_title : String?
    let page7 : String?
    let description : String?
    let task_credits : String?
    let service_location : String?
    let lattitude : String?
    let longtitude : String?
    let task_status : String?
    let task_completed_on : String?
    let task_cancel_status : String?
    let cancel_description : String?
    let task_cancel_on : String?
    let task_submitted_on : String?
    let vendor_review : String?
    let vendor_review_givenon : String?*/
    

    enum CodingKeys: String, CodingKey {

        case received_quotes = "received_quotes"
     /*   case taskid = "taskid"
        case customerid = "customerid"
        case category = "category"
        case page1_title = "page1_title"
        case page1 = "page1"
        case page2_title = "page2_title"
        case page2 = "page2"
        case page3_title = "page3_title"
        case page3 = "page3"
        case page4_title = "page4_title"
        case page4 = "page4"
        case page5_title = "page5_title"
        case page5 = "page5"
        case page6_title = "page6_title"
        case page6 = "page6"
        case page7_title = "page7_title"
        case page7 = "page7"
        case description = "description"
        case task_credits = "task_credits"
        case service_location = "service_location"
        case lattitude = "lattitude"
        case longtitude = "longtitude"
        case task_status = "task_status"
        case task_completed_on = "task_completed_on"
        case task_cancel_status = "task_cancel_status"
        case cancel_description = "cancel_description"
        case task_cancel_on = "task_cancel_on"
        case task_submitted_on = "task_submitted_on"
        case vendor_review = "vendor_review"
        case vendor_review_givenon = "vendor_review_givenon"*/
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        received_quotes = try values.decodeIfPresent(String.self, forKey: .received_quotes)
        /*taskid = try values.decodeIfPresent(String.self, forKey: .taskid)
        customerid = try values.decodeIfPresent(String.self, forKey: .customerid)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        page1_title = try values.decodeIfPresent(String.self, forKey: .page1_title)
        page1 = try values.decodeIfPresent(String.self, forKey: .page1)
        page2_title = try values.decodeIfPresent(String.self, forKey: .page2_title)
        page2 = try values.decodeIfPresent(String.self, forKey: .page2)
        page3_title = try values.decodeIfPresent(String.self, forKey: .page3_title)
        page3 = try values.decodeIfPresent(String.self, forKey: .page3)
        page4_title = try values.decodeIfPresent(String.self, forKey: .page4_title)
        page4 = try values.decodeIfPresent(String.self, forKey: .page4)
        page5_title = try values.decodeIfPresent(String.self, forKey: .page5_title)
        page5 = try values.decodeIfPresent(String.self, forKey: .page5)
        page6_title = try values.decodeIfPresent(String.self, forKey: .page6_title)
        page6 = try values.decodeIfPresent(String.self, forKey: .page6)
        page7_title = try values.decodeIfPresent(String.self, forKey: .page7_title)
        page7 = try values.decodeIfPresent(String.self, forKey: .page7)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        task_credits = try values.decodeIfPresent(String.self, forKey: .task_credits)
        service_location = try values.decodeIfPresent(String.self, forKey: .service_location)
        lattitude = try values.decodeIfPresent(String.self, forKey: .lattitude)
        longtitude = try values.decodeIfPresent(String.self, forKey: .longtitude)
        task_status = try values.decodeIfPresent(String.self, forKey: .task_status)
        task_completed_on = try values.decodeIfPresent(String.self, forKey: .task_completed_on)
        task_cancel_status = try values.decodeIfPresent(String.self, forKey: .task_cancel_status)
        cancel_description = try values.decodeIfPresent(String.self, forKey: .cancel_description)
        task_cancel_on = try values.decodeIfPresent(String.self, forKey: .task_cancel_on)
        task_submitted_on = try values.decodeIfPresent(String.self, forKey: .task_submitted_on)
        vendor_review = try values.decodeIfPresent(String.self, forKey: .vendor_review)
        vendor_review_givenon = try values.decodeIfPresent(String.self, forKey: .vendor_review_givenon)*/
    }

}
