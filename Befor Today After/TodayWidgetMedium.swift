//
//  TodayWidgetMedium.swift
//  TodoApp
//
//  Created by Amini on 13/09/22.
//

import SwiftUI
import WidgetKit

struct TodayWidgetMedium: View {
    
    let entry: TodayEntry
    @EnvironmentObject var themeSc: ThemeSource
    
    var body: some View {
        ZStack {
            themeSc.current.baseColor.ignoresSafeArea()
            
            HStack(alignment: .center, spacing: 20) {
                
                VStack(alignment: .leading, spacing:0) {
                    Text("TODAY")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(themeSc.current.primaryColor)
                    
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .frame(height: 2, alignment: .center)
                        .foregroundColor(themeSc.current.primaryColor)
                        .padding(.bottom, 8)
                    
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
                    
                }
                .padding(.vertical, 4)
                
                Rectangle()
                    .frame(width: 2)
                    .foregroundColor(themeSc.current.primaryColor)
                
                VStack(alignment: .leading, spacing:0) {
                    Text("TOMORROW")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(themeSc.current.primaryColor)
                    
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .frame(height: 2, alignment: .center)
                        .foregroundColor(themeSc.current.primaryColor)
                        .padding(.bottom, 8)

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
                }
                .padding(.vertical, 8)

            }
            .padding(4)
        }
    }
}

//struct TodayWidgetMedium_Previews: PreviewProvider {
//    static var previews: some View {
//        TodayWidgetMedium(entry: TodayEntry(date: Date(), todos: []))
//            .previewContext(WidgetPreviewContext(family: .systemMedium))
//            .environmentObject(ThemeSource())
//    }
//}
