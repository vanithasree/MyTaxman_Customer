//
//  ChatModel.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 04/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct ChatBase : Codable {
    let code : String?
    let desc : [Chat]?
    let chat_img_path : String?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case desc = "desc"
        case chat_img_path = "chat_img_path"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        desc = try values.decodeIfPresent([Chat].self, forKey: .desc)
        chat_img_path = try values.decodeIfPresent(String.self, forKey: .chat_img_path)
    }

}

struct Chat : Codable {
    let chatid : String?
    let customerid : String?
    let vendorid : String?
    let taskid : String?
    let quoteid : String?
    let message : String?
    let chat_image : String?
    let sent_by : String?
    let sent_on : String?
    let seen_on : String?

    enum CodingKeys: String, CodingKey {

        case chatid = "chatid"
        case customerid = "customerid"
        case vendorid = "vendorid"
        case taskid = "taskid"
        case quoteid = "quoteid"
        case message = "message"
        case chat_image = "chat_image"
        case sent_by = "sent_by"
        case sent_on = "sent_on"
        case seen_on = "seen_on"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        chatid = try values.decodeIfPresent(String.self, forKey: .chatid)
        customerid = try values.decodeIfPresent(String.self, forKey: .customerid)
        vendorid = try values.decodeIfPresent(String.self, forKey: .vendorid)
        taskid = try values.decodeIfPresent(String.self, forKey: .taskid)
        quoteid = try values.decodeIfPresent(String.self, forKey: .quoteid)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        chat_image = try values.decodeIfPresent(String.self, forKey: .chat_image)
        sent_by = try values.decodeIfPresent(String.self, forKey: .sent_by)
        sent_on = try values.decodeIfPresent(String.self, forKey: .sent_on)
        seen_on = try values.decodeIfPresent(String.self, forKey: .seen_on)
    }

}

struct SendChatBase : Codable {
    let code : String?
    let desc : Bool?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case desc = "desc"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        desc = try values.decodeIfPresent(Bool.self, forKey: .desc)
    }
}
