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
    let quoteid : String?
    let cost_estimate_flat : String?
    let cost_estimate_hourly : String?
    let cost_estimate_hourlyhours : String?
    let site_inspection : String?
    let more_information : String?
    let additional_comments : String?
    let quoted_on : String?
    let quote_accepted_on : String?
    let vendorid : String?
    let business_name : String?
    let ven_callid : String?
    let vendorname : String?
    let email : String?
    let mobile_no : String?
    let service_types : String?
    let profile_pic : String?
    let featured : String?
    let service_areas : String?
    let vendor_review : String?
    let vendor_review_givenon : String?
    let taskid : String?
    let expertscount : String?
    let vendor_avg_rating : String?
    let success_quote_count : String?

    enum CodingKeys: String, CodingKey {

        case quote_status = "quote_status"
        case quoteid = "quoteid"
        case cost_estimate_flat = "cost_estimate_flat"
        case cost_estimate_hourly = "cost_estimate_hourly"
        case cost_estimate_hourlyhours = "cost_estimate_hourlyhours"
        case site_inspection = "site_inspection"
        case more_information = "more_information"
        case additional_comments = "additional_comments"
        case quoted_on = "quoted_on"
        case quote_accepted_on = "quote_accepted_on"
        case vendorid = "vendorid"
        case business_name = "business_name"
        case ven_callid = "ven_callid"
        case vendorname = "vendorname"
        case email = "email"
        case mobile_no = "mobile_no"
        case service_types = "service_types"
        case profile_pic = "profile_pic"
        case featured = "featured"
        case service_areas = "service_areas"
        case vendor_review = "vendor_review"
        case vendor_review_givenon = "vendor_review_givenon"
        case taskid = "taskid"
        case expertscount = "expertscount"
        case vendor_avg_rating = "vendor_avg_rating"
        case success_quote_count = "success_quote_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        quote_status = try values.decodeIfPresent(String.self, forKey: .quote_status)
        quoteid = try values.decodeIfPresent(String.self, forKey: .quoteid)
        cost_estimate_flat = try values.decodeIfPresent(String.self, forKey: .cost_estimate_flat)
        cost_estimate_hourly = try values.decodeIfPresent(String.self, forKey: .cost_estimate_hourly)
        cost_estimate_hourlyhours = try values.decodeIfPresent(String.self, forKey: .cost_estimate_hourlyhours)
        site_inspection = try values.decodeIfPresent(String.self, forKey: .site_inspection)
        more_information = try values.decodeIfPresent(String.self, forKey: .more_information)
        additional_comments = try values.decodeIfPresent(String.self, forKey: .additional_comments)
        quoted_on = try values.decodeIfPresent(String.self, forKey: .quoted_on)
        quote_accepted_on = try values.decodeIfPresent(String.self, forKey: .quote_accepted_on)
        vendorid = try values.decodeIfPresent(String.self, forKey: .vendorid)
        business_name = try values.decodeIfPresent(String.self, forKey: .business_name)
        ven_callid = try values.decodeIfPresent(String.self, forKey: .ven_callid)
        vendorname = try values.decodeIfPresent(String.self, forKey: .vendorname)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        mobile_no = try values.decodeIfPresent(String.self, forKey: .mobile_no)
        service_types = try values.decodeIfPresent(String.self, forKey: .service_types)
        profile_pic = try values.decodeIfPresent(String.self, forKey: .profile_pic)
        featured = try values.decodeIfPresent(String.self, forKey: .featured)
        service_areas = try values.decodeIfPresent(String.self, forKey: .service_areas)
        vendor_review = try values.decodeIfPresent(String.self, forKey: .vendor_review)
        vendor_review_givenon = try values.decodeIfPresent(String.self, forKey: .vendor_review_givenon)
        taskid = try values.decodeIfPresent(String.self, forKey: .taskid)
        expertscount = try values.decodeIfPresent(String.self, forKey: .expertscount)
        vendor_avg_rating = try values.decodeIfPresent(String.self, forKey: .vendor_avg_rating)
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
    let quoteid : String?
    let vendorid : String?
    let cost_estimate_flat : String?
    let cost_estimate_hourly : String?
    let cost_estimate_hourlyhours : String?
    let site_inspection : String?
    let more_information : String?
    let additional_comments : String?
    let quoted_on : String?
    let quote_status : String?
    let quote_accepted_on : String?
    let review : String?
    let star_given : String?
    let reviewed_on : String?
    let quote_callid : String?
    let ven_callid : String?
    let vendorname : String?
    let mobile_no : String?
    let otp_verified : String?
    let otp : String?
    let landline : String?
    let email : String?
    let password : String?
    let business_name : String?
    let aBN : String?
    let street_address : String?
    let location : String?
    let website : String?
    let service_types : String?
    let service_areas : String?
    let new_job_lead_notification : String?
    let message_notification : String?
    let quotes_notification : String?
    let daily_summary_notification : String?
    let newsletter_notification : String?
    let timezone : String?
    let wallet_balance : String?
    let call_availability_start : String?
    let call_availability_end : String?
    let do_not_distrub : String?
    let location_setting_allowed : String?
    let microphone_setting_allowed : String?
    let last_login : String?
    let registered_on : String?
    let password_updated_on : String?
    let deviceid : String?
    let device_token : String?
    let profile_pic : String?
    let portfolio1 : String?
    let portfolio2 : String?
    let portfolio3 : String?
    let portfolio4 : String?
    let portfolio5 : String?
    let portfolio6 : String?
    let portfolio7 : String?
    let portfolio8 : String?
    let portfolio9 : String?
    let portfolio10 : String?
    let portfolio11 : String?
    let portfolio12 : String?
    let portfolio13 : String?
    let portfolio14 : String?
    let portfolio15 : String?
    let insurance_doc : String?
    let insurance_doc_verified : String?
    let featured : String?
    let rmsg : [Rmsg]?

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
        case quoteid = "quoteid"
        case vendorid = "vendorid"
        case cost_estimate_flat = "cost_estimate_flat"
        case cost_estimate_hourly = "cost_estimate_hourly"
        case cost_estimate_hourlyhours = "cost_estimate_hourlyhours"
        case site_inspection = "site_inspection"
        case more_information = "more_information"
        case additional_comments = "additional_comments"
        case quoted_on = "quoted_on"
        case quote_status = "quote_status"
        case quote_accepted_on = "quote_accepted_on"
        case review = "review"
        case star_given = "star_given"
        case reviewed_on = "reviewed_on"
        case quote_callid = "quote_callid"
        case ven_callid = "ven_callid"
        case vendorname = "vendorname"
        case mobile_no = "mobile_no"
        case otp_verified = "otp_verified"
        case otp = "otp"
        case landline = "landline"
        case email = "email"
        case password = "password"
        case business_name = "business_name"
        case aBN = "ABN"
        case street_address = "street_address"
        case location = "location"
        case website = "website"
        case service_types = "service_types"
        case service_areas = "service_areas"
        case new_job_lead_notification = "new_job_lead_notification"
        case message_notification = "message_notification"
        case quotes_notification = "quotes_notification"
        case daily_summary_notification = "daily_summary_notification"
        case newsletter_notification = "newsletter_notification"
        case timezone = "timezone"
        case wallet_balance = "wallet_balance"
        case call_availability_start = "call_availability_start"
        case call_availability_end = "call_availability_end"
        case do_not_distrub = "do_not_distrub"
        case location_setting_allowed = "location_setting_allowed"
        case microphone_setting_allowed = "microphone_setting_allowed"
        case last_login = "last_login"
        case registered_on = "registered_on"
        case password_updated_on = "password_updated_on"
        case deviceid = "deviceid"
        case device_token = "device_token"
        case profile_pic = "profile_pic"
        case portfolio1 = "portfolio1"
        case portfolio2 = "portfolio2"
        case portfolio3 = "portfolio3"
        case portfolio4 = "portfolio4"
        case portfolio5 = "portfolio5"
        case portfolio6 = "portfolio6"
        case portfolio7 = "portfolio7"
        case portfolio8 = "portfolio8"
        case portfolio9 = "portfolio9"
        case portfolio10 = "portfolio10"
        case portfolio11 = "portfolio11"
        case portfolio12 = "portfolio12"
        case portfolio13 = "portfolio13"
        case portfolio14 = "portfolio14"
        case portfolio15 = "portfolio15"
        case insurance_doc = "insurance_doc"
        case insurance_doc_verified = "insurance_doc_verified"
        case featured = "featured"
        case rmsg = "rmsg"
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
        quoteid = try values.decodeIfPresent(String.self, forKey: .quoteid)
        vendorid = try values.decodeIfPresent(String.self, forKey: .vendorid)
        cost_estimate_flat = try values.decodeIfPresent(String.self, forKey: .cost_estimate_flat)
        cost_estimate_hourly = try values.decodeIfPresent(String.self, forKey: .cost_estimate_hourly)
        cost_estimate_hourlyhours = try values.decodeIfPresent(String.self, forKey: .cost_estimate_hourlyhours)
        site_inspection = try values.decodeIfPresent(String.self, forKey: .site_inspection)
        more_information = try values.decodeIfPresent(String.self, forKey: .more_information)
        additional_comments = try values.decodeIfPresent(String.self, forKey: .additional_comments)
        quoted_on = try values.decodeIfPresent(String.self, forKey: .quoted_on)
        quote_status = try values.decodeIfPresent(String.self, forKey: .quote_status)
        quote_accepted_on = try values.decodeIfPresent(String.self, forKey: .quote_accepted_on)
        review = try values.decodeIfPresent(String.self, forKey: .review)
        star_given = try values.decodeIfPresent(String.self, forKey: .star_given)
        reviewed_on = try values.decodeIfPresent(String.self, forKey: .reviewed_on)
        quote_callid = try values.decodeIfPresent(String.self, forKey: .quote_callid)
        ven_callid = try values.decodeIfPresent(String.self, forKey: .ven_callid)
        vendorname = try values.decodeIfPresent(String.self, forKey: .vendorname)
        mobile_no = try values.decodeIfPresent(String.self, forKey: .mobile_no)
        otp_verified = try values.decodeIfPresent(String.self, forKey: .otp_verified)
        otp = try values.decodeIfPresent(String.self, forKey: .otp)
        landline = try values.decodeIfPresent(String.self, forKey: .landline)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        business_name = try values.decodeIfPresent(String.self, forKey: .business_name)
        aBN = try values.decodeIfPresent(String.self, forKey: .aBN)
        street_address = try values.decodeIfPresent(String.self, forKey: .street_address)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        website = try values.decodeIfPresent(String.self, forKey: .website)
        service_types = try values.decodeIfPresent(String.self, forKey: .service_types)
        service_areas = try values.decodeIfPresent(String.self, forKey: .service_areas)
        new_job_lead_notification = try values.decodeIfPresent(String.self, forKey: .new_job_lead_notification)
        message_notification = try values.decodeIfPresent(String.self, forKey: .message_notification)
        quotes_notification = try values.decodeIfPresent(String.self, forKey: .quotes_notification)
        daily_summary_notification = try values.decodeIfPresent(String.self, forKey: .daily_summary_notification)
        newsletter_notification = try values.decodeIfPresent(String.self, forKey: .newsletter_notification)
        timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
        wallet_balance = try values.decodeIfPresent(String.self, forKey: .wallet_balance)
        call_availability_start = try values.decodeIfPresent(String.self, forKey: .call_availability_start)
        call_availability_end = try values.decodeIfPresent(String.self, forKey: .call_availability_end)
        do_not_distrub = try values.decodeIfPresent(String.self, forKey: .do_not_distrub)
        location_setting_allowed = try values.decodeIfPresent(String.self, forKey: .location_setting_allowed)
        microphone_setting_allowed = try values.decodeIfPresent(String.self, forKey: .microphone_setting_allowed)
        last_login = try values.decodeIfPresent(String.self, forKey: .last_login)
        registered_on = try values.decodeIfPresent(String.self, forKey: .registered_on)
        password_updated_on = try values.decodeIfPresent(String.self, forKey: .password_updated_on)
        deviceid = try values.decodeIfPresent(String.self, forKey: .deviceid)
        device_token = try values.decodeIfPresent(String.self, forKey: .device_token)
        profile_pic = try values.decodeIfPresent(String.self, forKey: .profile_pic)
        portfolio1 = try values.decodeIfPresent(String.self, forKey: .portfolio1)
        portfolio2 = try values.decodeIfPresent(String.self, forKey: .portfolio2)
        portfolio3 = try values.decodeIfPresent(String.self, forKey: .portfolio3)
        portfolio4 = try values.decodeIfPresent(String.self, forKey: .portfolio4)
        portfolio5 = try values.decodeIfPresent(String.self, forKey: .portfolio5)
        portfolio6 = try values.decodeIfPresent(String.self, forKey: .portfolio6)
        portfolio7 = try values.decodeIfPresent(String.self, forKey: .portfolio7)
        portfolio8 = try values.decodeIfPresent(String.self, forKey: .portfolio8)
        portfolio9 = try values.decodeIfPresent(String.self, forKey: .portfolio9)
        portfolio10 = try values.decodeIfPresent(String.self, forKey: .portfolio10)
        portfolio11 = try values.decodeIfPresent(String.self, forKey: .portfolio11)
        portfolio12 = try values.decodeIfPresent(String.self, forKey: .portfolio12)
        portfolio13 = try values.decodeIfPresent(String.self, forKey: .portfolio13)
        portfolio14 = try values.decodeIfPresent(String.self, forKey: .portfolio14)
        portfolio15 = try values.decodeIfPresent(String.self, forKey: .portfolio15)
        insurance_doc = try values.decodeIfPresent(String.self, forKey: .insurance_doc)
        insurance_doc_verified = try values.decodeIfPresent(String.self, forKey: .insurance_doc_verified)
        featured = try values.decodeIfPresent(String.self, forKey: .featured)
        rmsg = try values.decodeIfPresent([Rmsg].self, forKey: .rmsg)
    }

}
