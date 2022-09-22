//
//  TodayWidgetEntryView.swift
//  Befor Today AfterExtension
//
//  Created by Amini on 22/09/22.
//

import SwiftUI
import WidgetKit

struct TodayWidgetEntryView: View {
    let entry: TodayEntry
    
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        switch family {
        case .systemSmall:
            TodayWidgetSmall(entry: entry)
                .environmentObject(ThemeSource())
            
        case .systemMedium:
            TodayWidgetMedium(entry: entry)
                .environmentObject(ThemeSource())
            
        case .accessoryRectangular:
            TodayWidgetRectangle(entry: entry)
            
        default:
            Text("not implemented")
        }
    }
}
