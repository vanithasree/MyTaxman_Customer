//
//  StringExtension.swift
//  jps
//
//  Created by Prem kumar on 06/05/20.
//  Copyright © 2020 vijaykarthik. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    func setColorForText(textForAttribute: String, withColor color: UIColor, withFont font: UIFont) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        // Swift 4.2 and above
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        self.addAttribute(NSAttributedString.Key.font, value: font, range: range)
    }
    
    func setLineSpaceForText(lineSpace: CGFloat = 2, alignment : NSTextAlignment){
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace // Whatever line spacing you want in points
        paragraphStyle.alignment = alignment
        self.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, self.length))
    }
    
}

extension String {
    
    
    /// Handles 10 or 11 digit phone numbers
    ///
    /// - Returns: formatted phone number or original value
    public func toPhoneNumber() -> String {
        let digits = self.digitsOnly
        if digits.count == 10 {
            return digits.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2 $3", options: .regularExpression, range: nil)
        }
        else if digits.count == 11 {
            return digits.replacingOccurrences(of: "(\\d{1})(\\d{3})(\\d{3})(\\d+)", with: "$1($2)-$3-$4", options: .regularExpression, range: nil)
        }
        else {
            return self
        }
    }
    
    func trim() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    func grouping(every groupSize: String.IndexDistance, with separator: Character) -> String {
        let cleanedUpCopy = replacingOccurrences(of: String(separator), with: "")
        return String(cleanedUpCopy.enumerated().map() {
            $0.offset % groupSize == 0 ? [separator, $0.element] : [$0.element]
        }.joined().dropFirst())
    }
    
    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ss.ZZZ")-> Date? {
        
        let dateFormatter = DateFormatter()
        //        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        //        dateFormatter.locale = Locale(identifier: "fa-IR")
        //        dateFormatter.calendar = Calendar(identifier: .gregorian)
        //        dateFormatter.timeZone = NSTimeZone.init(abbreviation: "UTC") as TimeZone?
        
        //        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        
        return date
        
    }
    
    
    //"yyyy-MM-dd'T'HH:mm:ss"
    func convertStringToDate() -> Date? {
        
        let startIndex = 0
        let endIndex = 19
        
        let start = String.Index(utf16Offset: startIndex, in: self)
        let end = String.Index(utf16Offset: endIndex, in: self)
        
        let substring = String(self[start..<end])
        
        //   print("Date String ==\(substring)")
        //    print("Date ==\(substring.convertToDate(format: "yyyy-MM-dd'T'HH:mm:ss"))")
        
        return substring.convertToDate(format: "yyyy-MM-dd'T'HH:mm:ss")
        
    }
    
    
    
    //"yyyy-MM-dd'T'HH:mm:ss"
    func convertToDate(format: String = "yyyy-MM-dd'T'HH:mm:ss") -> Date? {
        let formatter = DateFormatter()
        //        formatter.timeZone = NSTimeZone.init(abbreviation: "UTC") as TimeZone?
        formatter.timeZone = NSTimeZone.init(abbreviation: "UTC") as TimeZone?
        formatter.dateFormat = format
        //  formatter.dateStyle = .short
        let date = formatter.date(from: self)
        return date
    }
    
    func convertDoubleToCurrency() -> String {
        let removeWhitespace = self.replacingOccurrences(of: " ", with: "")
        let removeCurrency = removeWhitespace.replacingOccurrences(of: "$", with: "")
        //        let amount1 = Double(removeCurrency)
        guard let amount = Double(removeCurrency) else {
            return self
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "en_US")
        return numberFormatter.string(from: NSNumber(value: amount))!
    }
    
    public func isPhone()->Bool {
        if self.isAllDigits() == true {
            let phoneRegex = "[235689][0-9]{6}([0-9]{3})?"
            let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return  predicate.evaluate(with: self)
        }else {
            return false
        }
    }
    private func isAllDigits()->Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = self.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  self == filtered
    }
    
}


extension Date {
    
    /// Convert Date, Month, year
    var convertToDateFormat: String {
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: self)
    }
    
    var convertToDateString: String {
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: self)
    }
    
    var after30Days: Date? {
        // If you want to have exactly 30 days before
        let fromDate = Calendar.current.date(byAdding: .day, value: 30, to: self)
        return fromDate
    }
}

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension StringProtocol {

    /// Returns the string with only [0-9], all other characters are filtered out
    var digitsOnly: String {
        return String(filter(("0"..."9").contains))
    }

}
