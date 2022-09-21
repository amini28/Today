//
//  TimerAttributes.swift
//  TodoApp
//
//  Created by Amini on 20/09/22.
//

import ActivityKit
import SwiftUI

struct TimerAttributes: ActivityAttributes {
    public typealias TimerStatus = ContentState
    
    public struct ContentState: Codable, Hashable {
        var endTime: Date
    }
    
    var timerName: String
}
