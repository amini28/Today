//
//  Extension+View.swift
//  TodoApp
//
//  Created by Amini on 20/08/22.
//

import Foundation
import SwiftUI

extension View {
    func placeholder<Content: View>(when shouldShow: Bool,
                                    alignment: Alignment = .leading,
                                    @ViewBuilder placeholder: ()-> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    func placeholder(_ text: String,
                     when show: Bool,
                     alignment: Alignment = .leading) -> some View {
        
        placeholder(when: show, alignment: alignment) {
            Text(text).foregroundColor(.gray)
        }
    }

    @ViewBuilder
    func header(string: String, foregroundColor: Color) -> some View {
        Text(string)
            .font(.caption)
            .foregroundColor(foregroundColor)
    }
    
    @ViewBuilder
    func footer(string: String, foregroundColor: Color) -> some View {
        Text(string)
            .font(.caption2)
            .foregroundColor(foregroundColor)
    }

}


extension Date {
    func formatString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
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

extension String {
    func first10() -> String {
        if self.count > 10 {
            return "\(String(self.prefix(10)))..."
        }
        return self
    }
}
