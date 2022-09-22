//
//  View+ViewBuilder.swift
//  TodoApp
//
//  Created by Amini on 22/09/22.
//

import Foundation
import SwiftUI

extension View {
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
