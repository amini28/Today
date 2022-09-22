//
//  ActivityWidget.swift
//  Befor Today AfterExtension
//
//  Created by Amini on 22/09/22.
//

import ActivityKit
import WidgetKit
import SwiftUI


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
