//
//  Date+24Format.swift
//  TodoApp
//
//  Created by Amini on 22/09/22.
//

import SwiftUI

extension Date {
    func startEndTime() -> (starDate: Date, endDate: Date) {
        if let calendar = NSCalendar(calendarIdentifier: .gregorian) {
            var components = calendar.components([.year, .month, .day, .hour, .minute, .second], from: self)
            
            components.hour = 00
            components.minute = 00
            components.second = 00
            let startDate = calendar.date(from: components)
            
            components.hour = 23
            components.minute = 59
            components.second = 59
            let endDate = calendar.date(from: components)
            
            return (startDate!, endDate!)
        } else {
            return (Date(), Date())
        }
    }
}
