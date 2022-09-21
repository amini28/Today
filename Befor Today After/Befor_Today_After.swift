//
//  Befor_Today_After.swift
//  Befor Today After
//
//  Created by Amini on 10/09/22.
//

import WidgetKit
import SwiftUI
import Intents
import ActivityKit

@main
struct Befor_Today_After: WidgetBundle {

    @WidgetBundleBuilder
    var body: some Widget {
        StaticWidget()
        
        if #available(iOSApplicationExtension 16.1, *) {
            ActivityWidget()
        }
    }
}

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

@available(iOSApplicationExtension 16.1, *)
struct TimerActivityView: View {
    let context: ActivityViewContext<TimerAttributes>
    
    var body: some View {
        VStack {
            Text(context.attributes.timerName)
                .font(.headline)
            
            ProgressView(value: 0, total: 100)
                .accentColor(.blue)
            
            Text(context.state.endTime, style: .timer)
        }
        .padding(.horizontal)

    }
}

@available(iOSApplicationExtension 16.1, *)
struct ActivityWidget: Widget {
    let kind: String = "Today"
    let controller = PersistenceController.shared

    var body: some WidgetConfiguration {

        ActivityConfiguration(for: TimerAttributes.self){ context in
            
            TimerActivityView(context: context)
            
        } dynamicIsland: { context in
            
            DynamicIsland {
                
                DynamicIslandExpandedRegion(.leading) {
                    Label("Next", systemImage: "checklist")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    Label {
                        Text("23:23")
                            .multilineTextAlignment(.trailing)
                            .frame(width: 50)
                            .monospacedDigit()
                        
                    } icon: {
                        Image(systemName: "timer")
                            .foregroundColor(.white)
                    }
                    .font(.headline)
                }
                
                DynamicIslandExpandedRegion(.center) {
                    Text("Title Todo Today")
                        .foregroundColor(.white)
                        .font(.title2)

                }
                
                DynamicIslandExpandedRegion(.bottom) {
                    Button {
                        // deep link into app
                    } label: {
                        Text("Done")
                            .font(.headline)
                    }
                    .foregroundColor(.white)
                    .font(.headline)
                }
                
            } compactLeading: {
                // compact leading view
                Image(systemName: "arrow.right.to.line")
                    .foregroundColor(.white)

            } compactTrailing: {
                // compact trailing view
                Image(systemName: "timer")
                    .foregroundColor(.white)

            } minimal: {
                // minimal view
                Image(systemName: "timer")
                    .foregroundColor(.white)
            }
        }

    }
}

