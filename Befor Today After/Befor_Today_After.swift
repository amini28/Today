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


