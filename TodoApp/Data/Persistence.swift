//
//  Persistence.swift
//  TodoApp
//
//  Created by Amini on 15/08/22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        ["Clean dishes", "Write Apa yang akan terjadi jika panjang Todo App", "Subscribe to Me"].forEach { title in
            let todo = Todo(context: viewContext)
            todo.id = UUID()
            todo.title = title
            todo.done = .random()
            todo.alert = .random()
            todo.time = Date()
        }

        ["Clean dishes date 2", "Write Apa yang akan terjadi jika panjang Todo App date 2", "Subscribe to Me date2"].forEach { title in
            let todo = Todo(context: viewContext)
            todo.id = UUID()
            todo.title = title
            todo.done = false
            todo.alert = .random()
            
            todo.time = Calendar.current.date(byAdding: .day, value: 1, to: .now)
        }
        
        ["Clean dishes date 3", "Write Apa yang akan terjadi jika panjang Todo App date 3", "Subscribe to Me date3"].forEach { title in
            let todo = Todo(context: viewContext)
            todo.id = UUID()
            todo.title = title
            todo.done = true
            todo.alert = .random()
            
            todo.time = Calendar.current.date(byAdding: .day, value: -1, to: .now)
        }

        do {
            try viewContext.save()
        } catch {

            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "TodoApp")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
