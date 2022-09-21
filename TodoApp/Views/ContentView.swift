//
//  ContentView.swift
//  TodoApp
//
//  Created by Amini on 15/08/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject var themeSc: ThemeSource
    
    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .linear)
    var todos: FetchedResults<Todo>
    
    @State private var showAddTodoSheet: Bool = false

    @State private var todoTime: Date = Date()
    @State private var selectedTab: Int = 1
    
    let tabs: [Tab] = [
        .init(title: "Yesterday"),
        .init(title: "Today"),
        .init(title: "Tomorrow")
    ]
    
    var body: some View {
        NavigationStack {
            content
        }
        .accentColor(themeSc.current.primaryColor)
    }
    
    var content: some View {
        ZStack {
            themeSc.current.baseColor.ignoresSafeArea()
            GeometryReader { geo in
                VStack {
                    Tabs(fixed: false, tabs: tabs, geoWidth: geo.size.width, selectedTab: $selectedTab).environmentObject(themeSc)
                        .padding(10)
                    
                    TabView(selection: $selectedTab) {
                        TodoView(filter: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date())
                            .environment(\.managedObjectContext, viewContext)
                            .environmentObject(themeSc)
                            .tag(0)
                        
                        TodoView(filter: Date())
                            .environment(\.managedObjectContext, viewContext)
                            .environmentObject(themeSc)
                            .tag(1)
                        
                        TodoView(filter: Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date())
                            .environment(\.managedObjectContext, viewContext)
                            .environmentObject(themeSc)
                            .tag(2)
                        
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .foregroundColor(themeSc.current.primaryColor)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                
                Button{
                    showAddTodoSheet.toggle()
                } label: {
                    Label("Add Item", systemImage: "plus.app.fill")
                        .foregroundColor(themeSc.current.primaryColor)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                
                NavigationLink {
                    SettingsView()
                        .environmentObject(themeSc)
                } label : {
                    Label("Add Item", systemImage: "filemenu.and.selection")
                        .foregroundColor(themeSc.current.primaryColor)
                }
                
                
            }
            
        }
        .sheet(isPresented: $showAddTodoSheet) {
            FormView()
                .environment(\.managedObjectContext, viewContext)
                .environmentObject(themeSc)
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(ThemeSource())
    }
}
