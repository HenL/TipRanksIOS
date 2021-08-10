//
//  Date+StringFormat.swift
//  TipRanksIOSTask
//
//  Created by Hen Levy on 10/08/2021.
//

import Foundation

extension Date {
    var timeAgo: String {
        let components = Calendar.current.dateComponents([.minute, .hour, .day], from: self, to: Date())
        
        guard let day = components.day, day < 7 else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            return dateFormatter.string(from: self)
        }
        if day >= 1 {
            return "\(day) days ago"
        }
        if let hour = components.hour, hour < 24, hour >= 1 {
            return "\(hour) hours ago"
        }
        if let minute = components.minute, minute < 60, minute >= 5 {
            return "\(minute) minute ago"
        }
        else {
            return "Now"
        }
    }
}
