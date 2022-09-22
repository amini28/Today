//
//  StaticWidget.swift
//  Befor Today AfterExtension
//
//  Created by Amini on 22/09/22.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct StaticWidget: Widget {
    let kind: String = "Today"
    let controller = PersistenceController.shared

    var body: some WidgetConfiguration {

        StaticConfiguration(kind: kind, provider: TodayProvider(), content: { (entry) in
            TodayWidgetEntryView(entry: entry)
                .environment(\.managedObjectContext, controller.container.viewContext)
        })
        .configurationDisplayName("Today's Widget")
        .description("This is a Widget from Yesterday, Today, Tomorrow")
        .supportedFamilies([.systemSmall, .systemMedium, .accessoryRectangular])
        
    }
}
