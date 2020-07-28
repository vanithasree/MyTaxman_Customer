//
//  DateExtension.swift
//  jps
//
//  Created by vijaykarthik on 17/05/20.
//  Copyright © 2020 vijaykarthik. All rights reserved.
//

import Foundation

extension Date {
    
    static func dates(from fromDate: Date, to toDate: Date, count: Int) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date >= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: count, to: date) else { break }
            date = newDate
        }
        return dates
    }
    
    static func weeks(from fromDate: Date, to toDate: Date, count: Int) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date >= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .weekOfYear, value: count, to: date) else { break }
            date = newDate
        }
        return dates
    }
    
    static func months(from fromDate: Date, to toDate: Date, count: Int) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date >= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .month, value: count, to: date) else { break }
            date = newDate
        }
        return dates
    }
    
    func isEqualTo(_ date: Date) -> Bool {
      return self == date
    }

    func isGreaterThan(_ date: Date) -> Bool {
       return self > date
    }

    func isSmallerThan(_ date: Date) -> Bool {
       return self < date
    }
    
    func getFormattedDate(format: String) -> String {
           let dateformat = DateFormatter()
           dateformat.dateFormat = format
           return dateformat.string(from: self)
       }
    
    func getDateStringBasedOnDateFormat(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    func getMonthString(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        return dateFormatter.string(from: date)
    }
    
    /// Date to"yyyy-MM-dd'T'HH:mm:ss.ZZZ"
    /// //"yyyy-MM-dd'T'HH:mm:ss
    /// - Parameter format: format
    func dateAndTimetoString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        //2020-05-12T11:25:08.000Z
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone.init(abbreviation: "UTC") as TimeZone?
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func dateAndMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "dd MMM"
        return formatter.string(from: self)
    }
    
    func timeIn24HourFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    func startOfMonth() -> Date {
        var components = Calendar.current.dateComponents([.year,.month], from: self)
        components.day = 1
        let firstDateOfMonth: Date = Calendar.current.date(from: components)!
        return firstDateOfMonth
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func nextDate() -> Date {
        let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: self)
        return nextDate ?? Date()
    }
    
    func previousDate() -> Date {
        let previousDate = Calendar.current.date(byAdding: .day, value: -1, to: self)
        return previousDate ?? Date()
    }
    
    func addDays(numberOfDays: Int) -> Date {
        let previousDate = Calendar.current.date(byAdding: .day, value: numberOfDays, to: self)
        return previousDate ?? Date()
    }
    
    func addWeeks(numberOfWeeks: Int) -> Date {
        let previousDate = Calendar.current.date(byAdding: .weekOfYear, value: numberOfWeeks, to: self)
         return previousDate ?? Date()
     }
    
    func removeDays(numberOfDays: Int) -> Date {
        let previousDate = Calendar.current.date(byAdding: .day, value: -numberOfDays, to: self)
        return previousDate ?? Date()
    }
    
    func addMonths(numberOfMonths: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .month, value: numberOfMonths, to: self)
        return endDate ?? Date()
    }
    
    func removeMonths(numberOfMonths: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .month, value: -numberOfMonths, to: self)
        return endDate ?? Date()
    }
    
    func removeYears(numberOfYears: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .year, value: -numberOfYears, to: self)
        return endDate ?? Date()
    }
    
    func getHumanReadableDayString() -> String {
        let weekdays = [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday"
        ]
        
        let calendar = Calendar.current.component(.weekday, from: self)
        return weekdays[calendar - 1]
    }
    
    
    func time(since fromDate: Date) -> String {
        let earliest = self < fromDate ? self : fromDate
        let latest = (earliest == self) ? fromDate : self
        
        let allComponents: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let components:DateComponents = Calendar.current.dateComponents(allComponents, from: earliest, to: latest)
        let year = components.year  ?? 0
        let month = components.month  ?? 0
        let week = components.weekOfYear  ?? 0
        let day = components.day ?? 0
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        let second = components.second ?? 0
        
        let descendingComponents = ["year": year, "month": month, "week": week, "day": day, "hour": hour, "minute": minute, "second": second]
        for (period, timeAgo) in descendingComponents {
            if timeAgo > 0 {
                return "\(timeAgo.of(period)) ago"
            }
        }
        
        return "Just now"
    }
}
extension Int {
    func of(_ name: String) -> String {
        guard self != 1 else { return "\(self) \(name)" }
        return "\(self) \(name)s"
    }
}
