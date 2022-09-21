//
//  TodayProvider.swift
//  TodoApp
//
//  Created by Amini on 13/09/22.
//

import Foundation
import WidgetKit
import SwiftUI
import CoreData

struct TodayProvider: TimelineProvider {
    
    typealias Entry = TodayEntry
    
    func placeholder(in context: Context) -> TodayEntry {
        TodayEntry(date: Date(), todos: loadTodo(for: context.family))
    }
    
    func getSnapshot(in context: Context, completion: @escaping (TodayEntry) -> Void) {
        completion(TodayEntry(date: Date(), todos: loadTodo(for: context.family)))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<TodayEntry>) -> Void) {

        let date = Date()
        let entry = TodayEntry(
            date: date,
            todos: loadTodo(for: context.family),
            nextTodos: context.family == .systemMedium ? loadNextTodo() : []
        )

        // Create a date that's 30 seconds in the future.
        let nextUpdateDate = Calendar.current.date(byAdding: .minute, value: 2, to: date)!

        // Create the timeline with the entry and a reload policy with the date
        // for the next update.
        let timeline = Timeline(
            entries:[entry],
            policy: .after(nextUpdateDate)
        )

        // Call the completion to pass the timeline to WidgetKit.
        completion(timeline)
    }
    
    func loadNextTodo() -> [Todo] {
        let controller = PersistenceController.shared
        let fetchRequest: NSFetchRequest<Todo> = Todo.fetchRequest()
        
        do {
            
            let dateNow: Date = .now + 1
            let date = dateNow.startEndTime()
            fetchRequest.predicate = NSPredicate(format: "time >= %@ AND time =< %@ AND done == false", argumentArray: [date.starDate, date.endDate])

            
            let array = try controller.container.viewContext.fetch(fetchRequest) as [Todo]
            return array
        } catch let error {
            print("error FetchRequest \(error)")
            return []
        }

    }

    func loadTodo(for family: WidgetFamily) -> [Todo] {
        let controller = PersistenceController.shared
        let fetchRequest: NSFetchRequest<Todo> = Todo.fetchRequest()
        
        do {
            
            switch family {
            case .systemSmall:
                let dateNow: Date = .now
                let date = dateNow.startEndTime()
                fetchRequest.predicate = NSPredicate(format: "time >= %@ AND time =< %@ AND done == false", argumentArray: [date.starDate, date.endDate])

            case .systemMedium:
                fetchRequest.predicate = NSPredicate(format: "done == false")

            case .accessoryRectangular:
                let dateNow: Date = .now
                let date = dateNow.startEndTime()
                fetchRequest.predicate = NSPredicate(format: "time >= %@ AND time =< %@", argumentArray: [date.starDate, date.endDate])

            default: break
            }
            
            let array = try controller.container.viewContext.fetch(fetchRequest) as [Todo]
            return array
        } catch let error {
            print("error FetchRequest \(error)")
            return []
        }
    }
}
