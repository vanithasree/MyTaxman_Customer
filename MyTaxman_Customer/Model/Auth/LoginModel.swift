//
//  LoginModel.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 23/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
struct LoginBase : Codable {
    let desc : String?
    let code : String?
    let customerid : [Customerid]?

    enum CodingKeys: String, CodingKey {
        
        case desc = "desc"
        case code = "code"
        case customerid = "customerid"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        customerid = try values.decodeIfPresent([Customerid].self, forKey: .customerid)
    }
    
}


// MARK: Forgot password base
struct ForgotPasswordBase : Codable {
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

// MARK: Register base
struct Register_Base : Codable {
    let code : String?
    let desc : String?
    let customerid : [Customerid]?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case desc = "desc"
        case customerid = "customerid"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
        customerid = try values.decodeIfPresent([Customerid].self, forKey: .customerid)
    }

}

struct Customerid : Codable {
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



// MARK: Check mobile base
struct CheckMobile_Base : Codable {
    let code : String?
    let desc : String?
    let customer : [Customer]?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case desc = "desc"
        case customer = "customer"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
        customer = try values.decodeIfPresent([Customer].self, forKey: .customer)
    }

}

struct Customer : Codable {
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


// MARK: Resend otp base
struct ResendOtpBase : Codable {
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

// MARK: Otp varification base
struct OtpVerifyBase : Codable {
    let desc : String?
    let code : String?
    let customerid : String?

    enum CodingKeys: String, CodingKey {
        
        case desc = "desc"
        case code = "code"
        case customerid = "customerid"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        customerid = try values.decodeIfPresent(String.self, forKey: .customerid)
    }
    
}
