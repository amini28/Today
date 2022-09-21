//
//  TodayWidgetRectangle.swift
//  Befor Today AfterExtension
//
//  Created by Amini on 19/09/22.
//

import SwiftUI
import WidgetKit

struct TodayWidgetRectangle: View {
    let entry: TodayEntry
    
    var body: some View {
        HStack {
            Rectangle()
                .frame(width: 2)
                    
            if let (currentDo, nextDo) = doData() {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Current Task \((currentDo.time?.formatString(format: "HH:mm"))!)")
                        .font(.system(.caption, design: .monospaced))
                        .fontWeight(.bold)

                    Text("- \(currentDo.title!.first10())")
                        .font(.system(.caption2))
                    
                    
                    Text("Next Task at \((nextDo.time?.formatString(format: "HH:mm"))!)")
                        .font(.system(.caption, design: .monospaced))
                        .fontWeight(.bold)

                    Text("- \(nextDo.title!.first10())")
                        .font(.system(.caption2))
                    
                }
            }
            
        }
        
    }
    
    func doData() -> (current: Todo, next: Todo) {
        var currentDo: Todo = Todo()
        var nextDo: Todo = Todo()
        
        for todo in (entry.todos.sorted {$0.time! < $1.time! }) {
            if !todo.done {
                nextDo = todo
                break
            } else {
                currentDo = todo
            }
        }
        
        return (currentDo, nextDo)
    }
}

//struct TodayWidgetRect_Previews: PreviewProvider {
//    static var previews: some View {
//        TodayWidgetRectangle(entry: TodayEntry(date: Date(), todos: []))
//            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
//            .environmentObject(ThemeSource())
//    }
//}
