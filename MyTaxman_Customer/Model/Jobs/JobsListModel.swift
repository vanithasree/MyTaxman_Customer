//
//  JobsListModel.swift
//  MyTaxman_Customer
//
//  Created by Apple on 27/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct CustTaskListBase : Codable {
    let code : String?
    let desc : Desc?
    let no_of_vendor_count : String?
    
    enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case desc = "desc"
        case no_of_vendor_count = "No_of_vendor_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        desc = try values.decodeIfPresent(Desc.self, forKey: .desc)
        no_of_vendor_count = try values.decodeIfPresent(String.self, forKey: .no_of_vendor_count)
    }
    
}
struct Desc : Codable {
    let quotes : [Quotes]?
    
    enum CodingKeys: String, CodingKey {
        
        case quotes = "quotes"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        quotes = try values.decodeIfPresent([Quotes].self, forKey: .quotes)
    }
    
}
struct QuotesForTask : Codable {
    let ignore_reason : String?
    let quote_status : String?
    let reviewed_on : String?
    let cost_estimate_flat : String?
    let vendorid : String?
    let quoted_on : String?
    let review : String?
    let star_given : String?
    let taskid : String?
    let quote_accepted_on : String?
    let site_inspection : String?
    let more_information : String?
    let quote_callid : String?
    let cost_estimate_hourly : String?
    let quoteid : String?
    let customerid : String?
    let cost_estimate_hourlyhours : String?
    let additional_comments : String?
    
    enum CodingKeys: String, CodingKey {
        
        case ignore_reason = "ignore_reason"
        case quote_status = "quote_status"
        case reviewed_on = "reviewed_on"
        case cost_estimate_flat = "cost_estimate_flat"
        case vendorid = "vendorid"
        case quoted_on = "quoted_on"
        case review = "review"
        case star_given = "star_given"
        case taskid = "taskid"
        case quote_accepted_on = "quote_accepted_on"
        case site_inspection = "site_inspection"
        case more_information = "more_information"
        case quote_callid = "quote_callid"
        case cost_estimate_hourly = "cost_estimate_hourly"
        case quoteid = "quoteid"
        case customerid = "customerid"
        case cost_estimate_hourlyhours = "cost_estimate_hourlyhours"
        case additional_comments = "additional_comments"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ignore_reason = try values.decodeIfPresent(String.self, forKey: .ignore_reason)
        quote_status = try values.decodeIfPresent(String.self, forKey: .quote_status)
        reviewed_on = try values.decodeIfPresent(String.self, forKey: .reviewed_on)
        cost_estimate_flat = try values.decodeIfPresent(String.self, forKey: .cost_estimate_flat)
        vendorid = try values.decodeIfPresent(String.self, forKey: .vendorid)
        quoted_on = try values.decodeIfPresent(String.self, forKey: .quoted_on)
        review = try values.decodeIfPresent(String.self, forKey: .review)
        star_given = try values.decodeIfPresent(String.self, forKey: .star_given)
        taskid = try values.decodeIfPresent(String.self, forKey: .taskid)
        quote_accepted_on = try values.decodeIfPresent(String.self, forKey: .quote_accepted_on)
        site_inspection = try values.decodeIfPresent(String.self, forKey: .site_inspection)
        more_information = try values.decodeIfPresent(String.self, forKey: .more_information)
        quote_callid = try values.decodeIfPresent(String.self, forKey: .quote_callid)
        cost_estimate_hourly = try values.decodeIfPresent(String.self, forKey: .cost_estimate_hourly)
        quoteid = try values.decodeIfPresent(String.self, forKey: .quoteid)
        customerid = try values.decodeIfPresent(String.self, forKey: .customerid)
        cost_estimate_hourlyhours = try values.decodeIfPresent(String.self, forKey: .cost_estimate_hourlyhours)
        additional_comments = try values.decodeIfPresent(String.self, forKey: .additional_comments)
    }
    
}
struct Quotes : Codable {
    let received_quotes : String?
    let quoteid : String?
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
    let vendor : [Vendor]?
    
    enum CodingKeys: String, CodingKey {
        
        case received_quotes = "received_quotes"
        case quoteid = "quoteid"
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
        case vendor = "vendor"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        received_quotes = try values.decodeIfPresent(String.self, forKey: .received_quotes)
        quoteid = try values.decodeIfPresent(String.self, forKey: .quoteid)
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
        vendor = try values.decodeIfPresent([Vendor].self, forKey: .vendor)
    }
    
}

struct Vendor : Codable {
    let quote_status : String?
    let taskid : String?
    let vendor_avg_rating : String?
    let ven_callid : String?
    let vendorname : String?
    let service_types : String?
    let business_name : String?
    let vendorid : String?
    let quoteid : String?
    let cost_estimate_flat : String?
    let cost_estimate_hourly : String?
    let site_inspection : String?
    let quote_accepted_on : String?
    let more_information : String?
    let service_areas : String?
    let mobile_no : String?
    let additional_comments : String?
    let email : String?
    let vendor_review : String?
    let vendor_review_givenon : String?
    let quoted_on : String?
    let baseurl : String?
    let cost_estimate_hourlyhours : String?
    let expertscount : String?
    let profile_pic : String?
    let featured : String?
    let success_quote_count : String?
    
    enum CodingKeys: String, CodingKey {
        
        case quote_status = "quote_status"
        case taskid = "taskid"
        case vendor_avg_rating = "vendor_avg_rating"
        case ven_callid = "ven_callid"
        case vendorname = "vendorname"
        case service_types = "service_types"
        case business_name = "business_name"
        case vendorid = "vendorid"
        case quoteid = "quoteid"
        case cost_estimate_flat = "cost_estimate_flat"
        case cost_estimate_hourly = "cost_estimate_hourly"
        case site_inspection = "site_inspection"
        case quote_accepted_on = "quote_accepted_on"
        case more_information = "more_information"
        case service_areas = "service_areas"
        case mobile_no = "mobile_no"
        case additional_comments = "additional_comments"
        case email = "email"
        case vendor_review = "vendor_review"
        case vendor_review_givenon = "vendor_review_givenon"
        case quoted_on = "quoted_on"
        case baseurl = "baseurl"
        case cost_estimate_hourlyhours = "cost_estimate_hourlyhours"
        case expertscount = "expertscount"
        case profile_pic = "profile_pic"
        case featured = "featured"
        case success_quote_count = "success_quote_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        quote_status = try values.decodeIfPresent(String.self, forKey: .quote_status)
        taskid = try values.decodeIfPresent(String.self, forKey: .taskid)
        vendor_avg_rating = try values.decodeIfPresent(String.self, forKey: .vendor_avg_rating)
        ven_callid = try values.decodeIfPresent(String.self, forKey: .ven_callid)
        vendorname = try values.decodeIfPresent(String.self, forKey: .vendorname)
        service_types = try values.decodeIfPresent(String.self, forKey: .service_types)
        business_name = try values.decodeIfPresent(String.self, forKey: .business_name)
        vendorid = try values.decodeIfPresent(String.self, forKey: .vendorid)
        quoteid = try values.decodeIfPresent(String.self, forKey: .quoteid)
        cost_estimate_flat = try values.decodeIfPresent(String.self, forKey: .cost_estimate_flat)
        cost_estimate_hourly = try values.decodeIfPresent(String.self, forKey: .cost_estimate_hourly)
        site_inspection = try values.decodeIfPresent(String.self, forKey: .site_inspection)
        quote_accepted_on = try values.decodeIfPresent(String.self, forKey: .quote_accepted_on)
        more_information = try values.decodeIfPresent(String.self, forKey: .more_information)
        service_areas = try values.decodeIfPresent(String.self, forKey: .service_areas)
        mobile_no = try values.decodeIfPresent(String.self, forKey: .mobile_no)
        additional_comments = try values.decodeIfPresent(String.self, forKey: .additional_comments)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        vendor_review = try values.decodeIfPresent(String.self, forKey: .vendor_review)
        vendor_review_givenon = try values.decodeIfPresent(String.self, forKey: .vendor_review_givenon)
        quoted_on = try values.decodeIfPresent(String.self, forKey: .quoted_on)
        baseurl = try values.decodeIfPresent(String.self, forKey: .baseurl)
        cost_estimate_hourlyhours = try values.decodeIfPresent(String.self, forKey: .cost_estimate_hourlyhours)
        expertscount = try values.decodeIfPresent(String.self, forKey: .expertscount)
        profile_pic = try values.decodeIfPresent(String.self, forKey: .profile_pic)
        featured = try values.decodeIfPresent(String.self, forKey: .featured)
        success_quote_count = try values.decodeIfPresent(String.self, forKey: .success_quote_count)
    }
    
}



//Completed List
struct CompletedTaskListBase : Codable {
    let code : String?
    let desc : DescForCompletedTask?
    
    enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case desc = "desc"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        desc = try values.decodeIfPresent(DescForCompletedTask.self, forKey: .desc)
    }
    
}

struct Rmsg : Codable {
    let avg_rating : String?
    let quote_count : String?
    
    enum CodingKeys: String, CodingKey {
        
        case avg_rating = "avg_rating"
        case quote_count = "quote_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        avg_rating = try values.decodeIfPresent(String.self, forKey: .avg_rating)
        quote_count = try values.decodeIfPresent(String.self, forKey: .quote_count)
    }
    
}

struct DescForCompletedTask : Codable {
    let ilist : [Ilist]?
    
    enum CodingKeys: String, CodingKey {
        
        case ilist = "ilist"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ilist = try values.decodeIfPresent([Ilist].self, forKey: .ilist)
    }
    
}
struct Ilist : Codable {
    let password_updated_on : String?
    let reviewed_on : String?
    let vendor_review_givenon : String?
    let ven_callid : String?
    let cancel_description : String?
    let registered_on : String?
    let street_address : String?
    let portfolio8 : String?
    let description : String?
    let portfolio11 : String?
    let ignore_reason : String?
    let quote_status : String?
    let insurance_doc_verified : String?
    let vendorid : String?
    let page2_title : String?
    let page5_title : String?
    let page6 : String?
    let star_given : String?
    let portfolio3 : String?
    let mobile_no : String?
    let more_information : String?
    let service_location : String?
    let portfolio14 : String?
    let review : String?
    let vendorname : String?
    let message_notification : String?
    let location : String?
    let portfolio6 : String?
    let page1 : String?
    let task_credits : String?
    let portfolio10 : String?
    let quoted_on : String?
    let otp : String?
    let service_areas : String?
    let page7 : String?
    let new_job_lead_notification : String?
    let do_not_distrub : String?
    let category : String?
    let task_status : String?
    let portfolio9 : String?
    let task_completed_on : String?
    let call_availability_end : String?
    let aBN : String?
    let task_cancel_status : String?
    let timezone : String?
    let page3_title : String?
    let page2 : String?
    let landline : String?
    let portfolio1 : String?
    let cost_estimate_hourlyhours : String?
    let taskid : String?
    let page6_title : String?
    let task_cancel_on : String?
    let portfolio13 : String?
    let last_login : String?
    let website : String?
    let portfolio4 : String?
    let service_types : String?
    let vendor_review : String?
    let quotes_notification : String?
    let page3 : String?
    let email : String?
    let wallet_balance : String?
    let deviceid : String?
    let quote_callid : String?
    let profile_pic : String?
    let portfolio7 : String?
    let site_inspection : String?
    let quote_accepted_on : String?
    let password : String?
    let featured : String?
    let longtitude : String?
    let newsletter_notification : String?
    let portfolio12 : String?
    let page1_title : String?
    let task_submitted_on : String?
    let location_setting_allowed : String?
    let customerid : String?
    let page4_title : String?
    let page4 : String?
    let business_name : String?
    let portfolio2 : String?
    let insurance_doc : String?
    let daily_summary_notification : String?
    let page7_title : String?
    let call_availability_start : String?
    let rmsg : [Rmsg]?
    let device_token : String?
    let cost_estimate_hourly : String?
    let portfolio5 : String?
    let otp_verified : String?
    let portfolio15 : String?
    let additional_comments : String?
    let lattitude : String?
    let cost_estimate_flat : String?
    let page5 : String?
    let quoteid : String?
    let microphone_setting_allowed : String?
    
    enum CodingKeys: String, CodingKey {
        
        case password_updated_on = "password_updated_on"
        case reviewed_on = "reviewed_on"
        case vendor_review_givenon = "vendor_review_givenon"
        case ven_callid = "ven_callid"
        case cancel_description = "cancel_description"
        case registered_on = "registered_on"
        case street_address = "street_address"
        case portfolio8 = "portfolio8"
        case description = "description"
        case portfolio11 = "portfolio11"
        case ignore_reason = "ignore_reason"
        case quote_status = "quote_status"
        case insurance_doc_verified = "insurance_doc_verified"
        case vendorid = "vendorid"
        case page2_title = "page2_title"
        case page5_title = "page5_title"
        case page6 = "page6"
        case star_given = "star_given"
        case portfolio3 = "portfolio3"
        case mobile_no = "mobile_no"
        case more_information = "more_information"
        case service_location = "service_location"
        case portfolio14 = "portfolio14"
        case review = "review"
        case vendorname = "vendorname"
        case message_notification = "message_notification"
        case location = "location"
        case portfolio6 = "portfolio6"
        case page1 = "page1"
        case task_credits = "task_credits"
        case portfolio10 = "portfolio10"
        case quoted_on = "quoted_on"
        case otp = "otp"
        case service_areas = "service_areas"
        case page7 = "page7"
        case new_job_lead_notification = "new_job_lead_notification"
        case do_not_distrub = "do_not_distrub"
        case category = "category"
        case task_status = "task_status"
        case portfolio9 = "portfolio9"
        case task_completed_on = "task_completed_on"
        case call_availability_end = "call_availability_end"
        case aBN = "ABN"
        case task_cancel_status = "task_cancel_status"
        case timezone = "timezone"
        case page3_title = "page3_title"
        case page2 = "page2"
        case landline = "landline"
        case portfolio1 = "portfolio1"
        case cost_estimate_hourlyhours = "cost_estimate_hourlyhours"
        case taskid = "taskid"
        case page6_title = "page6_title"
        case task_cancel_on = "task_cancel_on"
        case portfolio13 = "portfolio13"
        case last_login = "last_login"
        case website = "website"
        case portfolio4 = "portfolio4"
        case service_types = "service_types"
        case vendor_review = "vendor_review"
        case quotes_notification = "quotes_notification"
        case page3 = "page3"
        case email = "email"
        case wallet_balance = "wallet_balance"
        case deviceid = "deviceid"
        case quote_callid = "quote_callid"
        case profile_pic = "profile_pic"
        case portfolio7 = "portfolio7"
        case site_inspection = "site_inspection"
        case quote_accepted_on = "quote_accepted_on"
        case password = "password"
        case featured = "featured"
        case longtitude = "longtitude"
        case newsletter_notification = "newsletter_notification"
        case portfolio12 = "portfolio12"
        case page1_title = "page1_title"
        case task_submitted_on = "task_submitted_on"
        case location_setting_allowed = "location_setting_allowed"
        case customerid = "customerid"
        case page4_title = "page4_title"
        case page4 = "page4"
        case business_name = "business_name"
        case portfolio2 = "portfolio2"
        case insurance_doc = "insurance_doc"
        case daily_summary_notification = "daily_summary_notification"
        case page7_title = "page7_title"
        case call_availability_start = "call_availability_start"
        case rmsg = "rmsg"
        case device_token = "device_token"
        case cost_estimate_hourly = "cost_estimate_hourly"
        case portfolio5 = "portfolio5"
        case otp_verified = "otp_verified"
        case portfolio15 = "portfolio15"
        case additional_comments = "additional_comments"
        case lattitude = "lattitude"
        case cost_estimate_flat = "cost_estimate_flat"
        case page5 = "page5"
        case quoteid = "quoteid"
        case microphone_setting_allowed = "microphone_setting_allowed"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        password_updated_on = try values.decodeIfPresent(String.self, forKey: .password_updated_on)
        reviewed_on = try values.decodeIfPresent(String.self, forKey: .reviewed_on)
        vendor_review_givenon = try values.decodeIfPresent(String.self, forKey: .vendor_review_givenon)
        ven_callid = try values.decodeIfPresent(String.self, forKey: .ven_callid)
        cancel_description = try values.decodeIfPresent(String.self, forKey: .cancel_description)
        registered_on = try values.decodeIfPresent(String.self, forKey: .registered_on)
        street_address = try values.decodeIfPresent(String.self, forKey: .street_address)
        portfolio8 = try values.decodeIfPresent(String.self, forKey: .portfolio8)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        portfolio11 = try values.decodeIfPresent(String.self, forKey: .portfolio11)
        ignore_reason = try values.decodeIfPresent(String.self, forKey: .ignore_reason)
        quote_status = try values.decodeIfPresent(String.self, forKey: .quote_status)
        insurance_doc_verified = try values.decodeIfPresent(String.self, forKey: .insurance_doc_verified)
        vendorid = try values.decodeIfPresent(String.self, forKey: .vendorid)
        page2_title = try values.decodeIfPresent(String.self, forKey: .page2_title)
        page5_title = try values.decodeIfPresent(String.self, forKey: .page5_title)
        page6 = try values.decodeIfPresent(String.self, forKey: .page6)
        star_given = try values.decodeIfPresent(String.self, forKey: .star_given)
        portfolio3 = try values.decodeIfPresent(String.self, forKey: .portfolio3)
        mobile_no = try values.decodeIfPresent(String.self, forKey: .mobile_no)
        more_information = try values.decodeIfPresent(String.self, forKey: .more_information)
        service_location = try values.decodeIfPresent(String.self, forKey: .service_location)
        portfolio14 = try values.decodeIfPresent(String.self, forKey: .portfolio14)
        review = try values.decodeIfPresent(String.self, forKey: .review)
        vendorname = try values.decodeIfPresent(String.self, forKey: .vendorname)
        message_notification = try values.decodeIfPresent(String.self, forKey: .message_notification)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        portfolio6 = try values.decodeIfPresent(String.self, forKey: .portfolio6)
        page1 = try values.decodeIfPresent(String.self, forKey: .page1)
        task_credits = try values.decodeIfPresent(String.self, forKey: .task_credits)
        portfolio10 = try values.decodeIfPresent(String.self, forKey: .portfolio10)
        quoted_on = try values.decodeIfPresent(String.self, forKey: .quoted_on)
        otp = try values.decodeIfPresent(String.self, forKey: .otp)
        service_areas = try values.decodeIfPresent(String.self, forKey: .service_areas)
        page7 = try values.decodeIfPresent(String.self, forKey: .page7)
        new_job_lead_notification = try values.decodeIfPresent(String.self, forKey: .new_job_lead_notification)
        do_not_distrub = try values.decodeIfPresent(String.self, forKey: .do_not_distrub)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        task_status = try values.decodeIfPresent(String.self, forKey: .task_status)
        portfolio9 = try values.decodeIfPresent(String.self, forKey: .portfolio9)
        task_completed_on = try values.decodeIfPresent(String.self, forKey: .task_completed_on)
        call_availability_end = try values.decodeIfPresent(String.self, forKey: .call_availability_end)
        aBN = try values.decodeIfPresent(String.self, forKey: .aBN)
        task_cancel_status = try values.decodeIfPresent(String.self, forKey: .task_cancel_status)
        timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
        page3_title = try values.decodeIfPresent(String.self, forKey: .page3_title)
        page2 = try values.decodeIfPresent(String.self, forKey: .page2)
        landline = try values.decodeIfPresent(String.self, forKey: .landline)
        portfolio1 = try values.decodeIfPresent(String.self, forKey: .portfolio1)
        cost_estimate_hourlyhours = try values.decodeIfPresent(String.self, forKey: .cost_estimate_hourlyhours)
        taskid = try values.decodeIfPresent(String.self, forKey: .taskid)
        page6_title = try values.decodeIfPresent(String.self, forKey: .page6_title)
        task_cancel_on = try values.decodeIfPresent(String.self, forKey: .task_cancel_on)
        portfolio13 = try values.decodeIfPresent(String.self, forKey: .portfolio13)
        last_login = try values.decodeIfPresent(String.self, forKey: .last_login)
        website = try values.decodeIfPresent(String.self, forKey: .website)
        portfolio4 = try values.decodeIfPresent(String.self, forKey: .portfolio4)
        service_types = try values.decodeIfPresent(String.self, forKey: .service_types)
        vendor_review = try values.decodeIfPresent(String.self, forKey: .vendor_review)
        quotes_notification = try values.decodeIfPresent(String.self, forKey: .quotes_notification)
        page3 = try values.decodeIfPresent(String.self, forKey: .page3)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        wallet_balance = try values.decodeIfPresent(String.self, forKey: .wallet_balance)
        deviceid = try values.decodeIfPresent(String.self, forKey: .deviceid)
        quote_callid = try values.decodeIfPresent(String.self, forKey: .quote_callid)
        profile_pic = try values.decodeIfPresent(String.self, forKey: .profile_pic)
        portfolio7 = try values.decodeIfPresent(String.self, forKey: .portfolio7)
        site_inspection = try values.decodeIfPresent(String.self, forKey: .site_inspection)
        quote_accepted_on = try values.decodeIfPresent(String.self, forKey: .quote_accepted_on)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        featured = try values.decodeIfPresent(String.self, forKey: .featured)
        longtitude = try values.decodeIfPresent(String.self, forKey: .longtitude)
        newsletter_notification = try values.decodeIfPresent(String.self, forKey: .newsletter_notification)
        portfolio12 = try values.decodeIfPresent(String.self, forKey: .portfolio12)
        page1_title = try values.decodeIfPresent(String.self, forKey: .page1_title)
        task_submitted_on = try values.decodeIfPresent(String.self, forKey: .task_submitted_on)
        location_setting_allowed = try values.decodeIfPresent(String.self, forKey: .location_setting_allowed)
        customerid = try values.decodeIfPresent(String.self, forKey: .customerid)
        page4_title = try values.decodeIfPresent(String.self, forKey: .page4_title)
        page4 = try values.decodeIfPresent(String.self, forKey: .page4)
        business_name = try values.decodeIfPresent(String.self, forKey: .business_name)
        portfolio2 = try values.decodeIfPresent(String.self, forKey: .portfolio2)
        insurance_doc = try values.decodeIfPresent(String.self, forKey: .insurance_doc)
        daily_summary_notification = try values.decodeIfPresent(String.self, forKey: .daily_summary_notification)
        page7_title = try values.decodeIfPresent(String.self, forKey: .page7_title)
        call_availability_start = try values.decodeIfPresent(String.self, forKey: .call_availability_start)
        rmsg = try values.decodeIfPresent([Rmsg].self, forKey: .rmsg)
        device_token = try values.decodeIfPresent(String.self, forKey: .device_token)
        cost_estimate_hourly = try values.decodeIfPresent(String.self, forKey: .cost_estimate_hourly)
        portfolio5 = try values.decodeIfPresent(String.self, forKey: .portfolio5)
        otp_verified = try values.decodeIfPresent(String.self, forKey: .otp_verified)
        portfolio15 = try values.decodeIfPresent(String.self, forKey: .portfolio15)
        additional_comments = try values.decodeIfPresent(String.self, forKey: .additional_comments)
        lattitude = try values.decodeIfPresent(String.self, forKey: .lattitude)
        cost_estimate_flat = try values.decodeIfPresent(String.self, forKey: .cost_estimate_flat)
        page5 = try values.decodeIfPresent(String.self, forKey: .page5)
        quoteid = try values.decodeIfPresent(String.self, forKey: .quoteid)
        microphone_setting_allowed = try values.decodeIfPresent(String.self, forKey: .microphone_setting_allowed)
    }
    
}
