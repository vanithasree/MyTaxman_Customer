//
//  EditProfile.swift
//  MyTaxman_Customer
//
//  Created by Vanithasree Rajeshkumar on 21/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct EditProfileBase : Codable {
    let code : String?
    let desc : String?
    let cus_updated_profile : [Cus_updated_profile]?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case desc = "desc"
        case cus_updated_profile = "cus_updated_profile"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
        cus_updated_profile = try values.decodeIfPresent([Cus_updated_profile].self, forKey: .cus_updated_profile)
    }

}
struct Cus_updated_profile : Codable {
    let customerid : String?
    let cus_callid : String?
    let customername : String?
    let email : String?
    let mobile : String?
    let password : String?
    let otp : String?
    let otp_verified : String?
    let device_token : String?
    let city : String?
    let postalcode : String?
    let deviceid : String?
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
        case device_token = "device_token"
        case city = "city"
        case postalcode = "postalcode"
        case deviceid = "deviceid"
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
        device_token = try values.decodeIfPresent(String.self, forKey: .device_token)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        postalcode = try values.decodeIfPresent(String.self, forKey: .postalcode)
        deviceid = try values.decodeIfPresent(String.self, forKey: .deviceid)
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


struct ChangePasswordBase : Codable {
    let code : String?
    let desc : String?
    
    enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case desc = "desc"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
    }
    
}
struct EditDescriptionBase : Codable {
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

