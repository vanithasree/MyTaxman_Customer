//
//  ClosedJobListModel.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 21/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct ClosedJobListBase : Codable {
    let desc : [ClosedJobListDesc]?
    let received_quotes : [Received_quotes]?
    let code : String?

    enum CodingKeys: String, CodingKey {

        case desc = "desc"
        case received_quotes = "received_quotes"
        case code = "code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc = try values.decodeIfPresent([ClosedJobListDesc].self, forKey: .desc)
        received_quotes = try values.decodeIfPresent([Received_quotes].self, forKey: .received_quotes)
        code = try values.decodeIfPresent(String.self, forKey: .code)
    }

}


struct ClosedJobListDesc : Codable {
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

struct Received_quotes : Codable {
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
    let received_quotes : String?
    let customerid : String?
    let category : String?
    let page4 : String?
    let page1_title : String?
    let page6_title : String?
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
        case received_quotes = "received_quotes"
        case customerid = "customerid"
        case category = "category"
        case page4 = "page4"
        case page1_title = "page1_title"
        case page6_title = "page6_title"
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
        received_quotes = try values.decodeIfPresent(String.self, forKey: .received_quotes)
        customerid = try values.decodeIfPresent(String.self, forKey: .customerid)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        page4 = try values.decodeIfPresent(String.self, forKey: .page4)
        page1_title = try values.decodeIfPresent(String.self, forKey: .page1_title)
        page6_title = try values.decodeIfPresent(String.self, forKey: .page6_title)
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


struct SubmitReviewBase : Codable {
    let desc : String?
    let code : String?

    enum CodingKeys: String, CodingKey {

        case desc = "desc"
        case code = "code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
        code = try values.decodeIfPresent(String.self, forKey: .code)
    }

}
