//
//  ToggleActivityView.swift
//  TodoApp
//
//  Created by Amini on 20/09/22.
//

import SwiftUI
import ActivityKit


@available(iOS 16.1, *)
struct ToggleActivityView: View {
    
    @EnvironmentObject var themeSc: ThemeSource

    @State private var activity: Activity<TimerAttributes>? = nil
    @State var activityShow = false

    
    var body: some View {
        Section(footer: footer(string: "Works on iOS 16", foregroundColor: themeSc.current.secondaryColor) ) {
                Toggle(isOn: $activityShow) {
                    Text("Show Activity Widget")
                        .font(.callout)
                        .foregroundColor(themeSc.current.primaryColor)
                }
                .toggleStyle(.switch)
                .tint(themeSc.current.primaryColor)
                .onChange(of: activityShow) { newValue in
                    onChangeActivityState()
                }
            }
            .foregroundColor(themeSc.current.primaryColor)
            .listRowBackground(themeSc.current.secondaryColor.opacity(0.1))
            .font(.system(size: 16, weight: .semibold, design: .default))
    }
    
    @available(iOS 16.1, *)
    private func onChangeActivityState() {
        if activityShow {
            let attributes = TimerAttributes(timerName: "")
            let state = TimerAttributes.TimerStatus(endTime: Date().addingTimeInterval(60*5))
            
            activity = try? Activity<TimerAttributes>.request(attributes: attributes, contentState: state, pushType: nil)
        } else {
            let state = TimerAttributes.TimerStatus(endTime: .now)
            
            Task {
                await activity?.end(using: state, dismissalPolicy: .immediate)
            }
        }
    }
}
