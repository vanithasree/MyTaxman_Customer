//
//  Validations.swift
//  jps
//
//  Created by vijaykarthik on 27/04/20.
//  Copyright © 2020 vijaykarthik. All rights reserved.
//

import Foundation
import UIKit

class ValidationManager {
    //For Email
    func hideMidChars(_ value: String) -> String {
        return String(value.enumerated().map { index, char in
            print(index, char, value)
            return [0,value.count - 1].contains(index) ? char : "*"
        })
    }
    
    //For Mobile
    func hideMidCharsInMobileString(_ value: String) -> String {
        return String(value.enumerated().map { index, char in
            print(index, char, value)
            return [0,value.count - 2 ,value.count - 1].contains(index) ? char : "*"
        })
    }
    
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator
        
        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])
                
                // move numbers iterator to the next index
                index = numbers.index(after: index)
                
            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
    
    func formatNumber(mobileNumber: String) -> String {
//        var number = mobileNumber
//        number = number.replacingOccurrences(of: "(", with: "")
//        number = number.replacingOccurrences(of: ")", with: "")
//        number = number.replacingOccurrences(of: " ", with: "")
//        number = number.replacingOccurrences(of: "-", with: "")
//        number = number.replacingOccurrences(of: "+", with: "")
//
//        let length = Int(number.count)
//
//        if length > 15 {
//            let index = number.index(number.startIndex, offsetBy: 15)
//
//            number = number.substring(to: index)
//        }
        let finalMobileString = mobileNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

        return finalMobileString
    }
    
    func getLength(mobileNumber: String) -> Int {
        
//        var number = mobileNumber
//        number = number.replacingOccurrences(of: "(", with: "")
//        number = number.replacingOccurrences(of: ")", with: "")
//        number = number.replacingOccurrences(of: " ", with: "")
//        number = number.replacingOccurrences(of: "-", with: "")
//        number = number.replacingOccurrences(of: "+", with: "")
        
//        let length = Int(number.count)
        let finalMobileString = mobileNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        return Int(finalMobileString.count)
        
    }
    
    func getMobileNumber(mobileNumber: String) -> String {
        
        let finalMobileString = mobileNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

//        var number = mobileNumber
//        number = number.replacingOccurrences(of: "(", with: "")
//        number = number.replacingOccurrences(of: ")", with: "")
//        number = number.replacingOccurrences(of: " ", with: "")
//        number = number.replacingOccurrences(of: "-", with: "")
//        number = number.replacingOccurrences(of: "+", with: "")
//        
//        //            let length = Int(number.count)
//        //            return length
        return finalMobileString
    }
    
}

extension String {
    
    /// Check is empty of Blank space is available in String
    var isBlank: Bool {
        if self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return true
        }
        return false
    }
    
    /// Password string is valid (between 5 to 15)
    var isValidPassword: Bool {
        if self.count < 6 {
            return false
        }
        return true
//        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{5,16}$"
//        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    
    /// Email string is valid
    var isEmail: Bool {
        let emailRegEx = "^[a-zA-Z0-9_+&*-]+(?:\\." + "[a-zA-Z0-9_+&*-]+)*@" + "(?:[a-zA-Z0-9-]+\\.)+[a-z" + "A-Z]{2,7}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if emailTest.evaluate(with: self), 3...40 ~= self.count {
            return true
        }
        
        return false
    }
    
    /// Mobile number string is valid (between 8 to 11)
    var isMobileNumber: Bool {
        
        let textString = ValidationManager().getMobileNumber(mobileNumber: self)
        
        if textString.isBlank {
            return false
        }
        
        if textString.isNumber && 8...11 ~= textString.count {
            return true
        }
        return false
    }
    
    var isContainsChar: Bool {
        let containsNumber: Bool = NSNotFound != (self as NSString).rangeOfCharacter(from: .letters).location
        return containsNumber
    }
    
    /// Number format validation
    var isNumber: Bool {
        let numbers = CharacterSet.decimalDigits.inverted
        return !self.isBlank && self.rangeOfCharacter(from: numbers) == nil
    }
    
    /// Profile name string is valid (between 3 to 25)
    var isName: Bool {
        
        if !self.isBlank && 2...32 ~= self.count {
            let numbers = CharacterSet.decimalDigits
            let decimalRange = self.rangeOfCharacter(from: numbers)
            
            if decimalRange != nil {
                //self.println("Numbers found")
                return false
            }
            return true
        }
        return false
    }
    
    
    /// Referral Code length is valid (between 5 to 15)
    var isValidReferralCodeLegth: Bool {
        
        if !self.isBlank && 5...8 ~= self.count {
            return true
        }
        return false
    }
    
    /// Promocode length is valid (between 5 to 8)
    var isValidPromoCodeLegth: Bool {
        
        if !self.isBlank && 5...8 ~= self.count {
            return true
        }
        return false
    }
    
}

