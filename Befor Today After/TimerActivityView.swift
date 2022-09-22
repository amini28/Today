//
//  TimerActivityView.swift
//  Befor Today AfterExtension
//
//  Created by Amini on 22/09/22.
//

import ActivityKit
import SwiftUI
import WidgetKit

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
