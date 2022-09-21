//
//  TodayEntry.swift
//  TodoApp
//
//  Created by Amini on 13/09/22.
//

import Foundation
import WidgetKit
import SwiftUI

struct TodayEntry: TimelineEntry {
    let date: Date
    let todos: [Todo]
    var nextTodos: [Todo] = []
    var isPlaceholder = false
}

