//
//  TodayWidgetSmall.swift
//  TodoApp
//
//  Created by Amini on 13/09/22.
//

import SwiftUI
import WidgetKit

struct TodayWidgetSmall: View {
    
    let entry: TodayEntry
    @EnvironmentObject var themeSc: ThemeSource
    
    var body: some View {
        ZStack {
//            themeSc.current.baseColor.ignoresSafeArea()
            Color.yellow.ignoresSafeArea()
            VStack(alignment: .leading, spacing:8) {
                
                if entry.todos.count > 1 {
                    Text(" TODAY")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(themeSc.current.primaryColor)
                        .frame(maxWidth: .infinity, alignment: .center)

                    Rectangle()
                        .foregroundColor(themeSc.current.primaryColor)
                        .frame(height: 2)

                    ForEach(entry.todos.sorted {$0.time! < $1.time!}[0..<3]) { todo in

                        if let title = todo.title,
                           let time = todo.time {

                            HStack {
                                Text(title.first10())
                                    .font(.callout)
                                    .foregroundColor(themeSc.current.primaryColor)
                                    .bold()

                                Spacer()

                                Text(" \(time.formatString(format: "HH:mm"))")
                                    .font(.caption)
                                    .foregroundColor(themeSc.current.primaryColor)
                                    .baselineOffset(6.0)
                            }

                        }
                    }
                } else {
                    Text("No Task \nRecorded")
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(themeSc.current.primaryColor)
                }
                
            }
            .padding(4)
        }
    }
}

//struct TodayWidgetSmall_Previews: PreviewProvider {
//    static var previews: some View {
//        TodayWidgetSmall(entry: TodayEntry(date: Date(), todos: []))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//            .environmentObject(ThemeSource())
//    }
//}
