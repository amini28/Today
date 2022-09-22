//
//  Extension+Date.swift
//  TodoApp
//
//  Created by Amini on 22/09/22.
//

import SwiftUI

extension Date {
    func formatString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
