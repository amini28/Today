//
//  TodoView.swift
//  TodoApp
//
//  Created by Amini on 17/08/22.
//

import SwiftUI
import WidgetKit

struct TodoView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var themeSc: ThemeSource

    @FetchRequest var todos: FetchedResults<Todo>
    
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()

    init(filter: Date) {

        if let calendar = NSCalendar(calendarIdentifier: .gregorian) {
            var components = calendar.components([.year, .month, .day, .hour, .minute, .second], from: filter)

            components.hour = 00
            components.minute = 00
            components.second = 00
            let startDate = calendar.date(from: components)

            components.hour = 23
            components.minute = 59
            components.second = 59
            let endDate = calendar.date(from: components)

            _todos = FetchRequest<Todo>(sortDescriptors: [SortDescriptor(\.time, order: .forward)], predicate: NSPredicate(format: "time >= %@ AND time =< %@", argumentArray: [startDate!, endDate!]), animation: .linear)
        } else {
            _todos = FetchRequest<Todo>(sortDescriptors: [], predicate: nil, animation: .linear)
        }
        
    }

    init() {
        _todos = FetchRequest<Todo>(sortDescriptors: [], predicate: nil, animation: .linear)
    }
        
    var body: some View {
        VStack {
            if !todos.isEmpty {
                List{
                    ForEach(todos) { todo in
                        HStack {
                            VStack {
                                
                                Text(todo.title ?? "")
                                    .font(.title3)
                                    .foregroundColor(todo.done ? themeSc.current.secondaryColor : themeSc.current.primaryColor)
                                    .bold()
                                    .strikethrough(todo.done, color: themeSc.current.secondaryColor)
                                
                                + Text(" \(todo.time?.formatString(format: "HH:mm") ?? "")")
                                    .font(.system(size: 12.0))
                                    .foregroundColor(todo.done ? themeSc.current.secondaryColor : themeSc.current.primaryColor)
                                    .baselineOffset(6.0)
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                    .onDelete { indexSet in
                        guard let index = indexSet.first else { return }
                        viewContext.delete(todos[index])
                        
                        try? viewContext.save()
                        
                        WidgetCenter.shared.reloadAllTimelines()
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
            }
        }
        .onReceive(timer, perform: { _ in
            DispatchQueue.global(qos: .background).async {

                for todo in todos {
                    if todo.time! < Date.now {
                        todo.done = true
                    }
                }

                do {
                    try viewContext.save()
                } catch {
                    print("no update")
                }
                
//                WidgetCenter.shared.reloadAllTimelines()
            }
        })
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView(filter: Date())
    }
}
