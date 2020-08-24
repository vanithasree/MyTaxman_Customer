//
//  InboxListModel.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 04/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
struct InboxListBase : Codable {
    let code : String?
    let desc : InboxListDesc?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case desc = "desc"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        desc = try values.decodeIfPresent(InboxListDesc.self, forKey: .desc)
    }

}


struct InboxListDesc : Codable {
    let ilist : [Inboxlist]?

    enum CodingKeys: String, CodingKey {

        case ilist = "ilist"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ilist = try values.decodeIfPresent([Inboxlist].self, forKey: .ilist)
    }

}

/*struct Inboxlist : Codable {
    let quoteid : String?
    let customerid : String?
    let vendorid : String?
    let taskid : String?
    let cost_estimate_flat : String?
    let cost_estimate_hourly : String?
    let cost_estimate_hourlyhours : String?
    let site_inspection : String?
    let more_information : String?
    let additional_comments : String?
    let ignore_reason : String?
    let quoted_on : String?
    let quote_status : String?
    let quote_accepted_on : String?
    let review : String?
    let star_given : String?
    let reviewed_on : String?
    let quote_callid : String?
    let customername : String?
    let vendorname : String?
    let profile_pic : String?
    let business_name : String?
    let ven_callid : String?
    let task_status : String?
    let task_cancel_status : String?
    let chatid : String?
    let rmsg : [InboxListRmsg]?

    enum CodingKeys: String, CodingKey {

        case quoteid = "quoteid"
        case customerid = "customerid"
        case vendorid = "vendorid"
        case taskid = "taskid"
        case cost_estimate_flat = "cost_estimate_flat"
        case cost_estimate_hourly = "cost_estimate_hourly"
        case cost_estimate_hourlyhours = "cost_estimate_hourlyhours"
        case site_inspection = "site_inspection"
        case more_information = "more_information"
        case additional_comments = "additional_comments"
        case ignore_reason = "ignore_reason"
        case quoted_on = "quoted_on"
        case quote_status = "quote_status"
        case quote_accepted_on = "quote_accepted_on"
        case review = "review"
        case star_given = "star_given"
        case reviewed_on = "reviewed_on"
        case quote_callid = "quote_callid"
        case customername = "customername"
        case vendorname = "vendorname"
        case profile_pic = "profile_pic"
        case business_name = "business_name"
        case ven_callid = "ven_callid"
        case task_status = "task_status"
        case task_cancel_status = "task_cancel_status"
        case chatid = "chatid"
        case rmsg = "rmsg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        quoteid = try values.decodeIfPresent(String.self, forKey: .quoteid)
        customerid = try values.decodeIfPresent(String.self, forKey: .customerid)
        vendorid = try values.decodeIfPresent(String.self, forKey: .vendorid)
        taskid = try values.decodeIfPresent(String.self, forKey: .taskid)
        cost_estimate_flat = try values.decodeIfPresent(String.self, forKey: .cost_estimate_flat)
        cost_estimate_hourly = try values.decodeIfPresent(String.self, forKey: .cost_estimate_hourly)
        cost_estimate_hourlyhours = try values.decodeIfPresent(String.self, forKey: .cost_estimate_hourlyhours)
        site_inspection = try values.decodeIfPresent(String.self, forKey: .site_inspection)
        more_information = try values.decodeIfPresent(String.self, forKey: .more_information)
        additional_comments = try values.decodeIfPresent(String.self, forKey: .additional_comments)
        ignore_reason = try values.decodeIfPresent(String.self, forKey: .ignore_reason)
        quoted_on = try values.decodeIfPresent(String.self, forKey: .quoted_on)
        quote_status = try values.decodeIfPresent(String.self, forKey: .quote_status)
        quote_accepted_on = try values.decodeIfPresent(String.self, forKey: .quote_accepted_on)
        review = try values.decodeIfPresent(String.self, forKey: .review)
        star_given = try values.decodeIfPresent(String.self, forKey: .star_given)
        reviewed_on = try values.decodeIfPresent(String.self, forKey: .reviewed_on)
        quote_callid = try values.decodeIfPresent(String.self, forKey: .quote_callid)
        customername = try values.decodeIfPresent(String.self, forKey: .customername)
        vendorname = try values.decodeIfPresent(String.self, forKey: .vendorname)
        profile_pic = try values.decodeIfPresent(String.self, forKey: .profile_pic)
        business_name = try values.decodeIfPresent(String.self, forKey: .business_name)
        ven_callid = try values.decodeIfPresent(String.self, forKey: .ven_callid)
        task_status = try values.decodeIfPresent(String.self, forKey: .task_status)
        task_cancel_status = try values.decodeIfPresent(String.self, forKey: .task_cancel_status)
        chatid = try values.decodeIfPresent(String.self, forKey: .chatid)
        rmsg = try values.decodeIfPresent([InboxListRmsg].self, forKey: .rmsg)
    }

}


struct InboxListRmsg : Codable {
    let recent_message : String?

    enum CodingKeys: String, CodingKey {

        case recent_message = "recent_message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        recent_message = try values.decodeIfPresent(String.self, forKey: .recent_message)
    }

}*/

struct Inboxlist : Codable {
    let quoteid : String?
    let customerid : String?
    let vendorid : String?
    let taskid : String?
    let cost_estimate_flat : String?
    let cost_estimate_hourly : String?
    let cost_estimate_hourlyhours : String?
    let site_inspection : String?
    let more_information : String?
    let additional_comments : String?
    let ignore_reason : String?
    let quoted_on : String?
    let quote_status : String?
    let quote_accepted_on : String?
    let review : String?
    let star_given : String?
    let reviewed_on : String?
    let quote_callid : String?
    let customername : String?
    let vendorname : String?
    let profile_pic : String?
    let business_name : String?
    let ven_callid : String?
    let category : String?
    let task_status : String?
    let task_cancel_status : String?
    let chatid : String?
    let rmsg : [InboxListRmsg]?
    
    enum CodingKeys: String, CodingKey {
        
        case quoteid = "quoteid"
        case customerid = "customerid"
        case vendorid = "vendorid"
        case taskid = "taskid"
        case cost_estimate_flat = "cost_estimate_flat"
        case cost_estimate_hourly = "cost_estimate_hourly"
        case cost_estimate_hourlyhours = "cost_estimate_hourlyhours"
        case site_inspection = "site_inspection"
        case more_information = "more_information"
        case additional_comments = "additional_comments"
        case ignore_reason = "ignore_reason"
        case quoted_on = "quoted_on"
        case quote_status = "quote_status"
        case quote_accepted_on = "quote_accepted_on"
        case review = "review"
        case star_given = "star_given"
        case reviewed_on = "reviewed_on"
        case quote_callid = "quote_callid"
        case customername = "customername"
        case vendorname = "vendorname"
        case profile_pic = "profile_pic"
        case business_name = "business_name"
        case ven_callid = "ven_callid"
        case category = "category"
        case task_status = "task_status"
        case task_cancel_status = "task_cancel_status"
        case chatid = "chatid"
        case rmsg = "rmsg"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        quoteid = try values.decodeIfPresent(String.self, forKey: .quoteid)
        customerid = try values.decodeIfPresent(String.self, forKey: .customerid)
        vendorid = try values.decodeIfPresent(String.self, forKey: .vendorid)
        taskid = try values.decodeIfPresent(String.self, forKey: .taskid)
        cost_estimate_flat = try values.decodeIfPresent(String.self, forKey: .cost_estimate_flat)
        cost_estimate_hourly = try values.decodeIfPresent(String.self, forKey: .cost_estimate_hourly)
        cost_estimate_hourlyhours = try values.decodeIfPresent(String.self, forKey: .cost_estimate_hourlyhours)
        site_inspection = try values.decodeIfPresent(String.self, forKey: .site_inspection)
        more_information = try values.decodeIfPresent(String.self, forKey: .more_information)
        additional_comments = try values.decodeIfPresent(String.self, forKey: .additional_comments)
        ignore_reason = try values.decodeIfPresent(String.self, forKey: .ignore_reason)
        quoted_on = try values.decodeIfPresent(String.self, forKey: .quoted_on)
        quote_status = try values.decodeIfPresent(String.self, forKey: .quote_status)
        quote_accepted_on = try values.decodeIfPresent(String.self, forKey: .quote_accepted_on)
        review = try values.decodeIfPresent(String.self, forKey: .review)
        star_given = try values.decodeIfPresent(String.self, forKey: .star_given)
        reviewed_on = try values.decodeIfPresent(String.self, forKey: .reviewed_on)
        quote_callid = try values.decodeIfPresent(String.self, forKey: .quote_callid)
        customername = try values.decodeIfPresent(String.self, forKey: .customername)
        vendorname = try values.decodeIfPresent(String.self, forKey: .vendorname)
        profile_pic = try values.decodeIfPresent(String.self, forKey: .profile_pic)
        business_name = try values.decodeIfPresent(String.self, forKey: .business_name)
        ven_callid = try values.decodeIfPresent(String.self, forKey: .ven_callid)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        task_status = try values.decodeIfPresent(String.self, forKey: .task_status)
        task_cancel_status = try values.decodeIfPresent(String.self, forKey: .task_cancel_status)
        chatid = try values.decodeIfPresent(String.self, forKey: .chatid)
        rmsg = try values.decodeIfPresent([InboxListRmsg].self, forKey: .rmsg)
    }
    
}
struct InboxListRmsg : Codable {
    let recent_message : String?
    
    enum CodingKeys: String, CodingKey {
        
        case recent_message = "recent_message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        recent_message = try values.decodeIfPresent(String.self, forKey: .recent_message)
    }
    
}
