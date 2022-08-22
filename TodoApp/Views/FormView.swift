//
//  FormView.swift
//  TodoApp
//
//  Created by Amini on 20/08/22.
//

import SwiftUI

enum Formday {
    case yesterday
    case today
    case tomorrow
}

struct FormView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    @EnvironmentObject var themeSc: ThemeSource
    
    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .linear)
    var todos: FetchedResults<Todo>
    
    @State private var newTodoTitle: String = ""
    @State var reminderActive = false

    @State var isToday: Formday = .today
    
    @State var hourSelection = 0
    @State var minuteSelection = 0
    
    @State var startHours = 0
    @State var startMinutes = 0
    
    var hours = [Int](0..<24)
    var minutes = [Int](0..<60)
    
    
    var body: some View {
        NavigationView{
            VStack {
                
                ZStack {
                    themeSc.current.primaryColor.ignoresSafeArea()
                    
                    Text("Add New A Do")
                        .font(.title3)
                        .fontWeight(.bold)
                        .textCase(.uppercase)
                        .foregroundColor(themeSc.current.baseColor)
                        .padding(.top, 20)
                }
                .frame(height: 58)
                
                Form {
                    Section (header: Text("Add Details").font(.callout).foregroundColor(themeSc.current.secondaryColor)) {
                        TextField("", text: $newTodoTitle)
                            .foregroundColor(themeSc.current.primaryColor)
                            .placeholder(when: true, alignment: .leading) {
                                Text("Write you do here ..")
                                    .foregroundColor(themeSc.current.secondaryColor)
                            }

                    }
                    .listRowBackground(themeSc.current.secondaryColor.opacity(0.1))

                    Section (header: Text("Set Reminder").font(.callout).foregroundColor(themeSc.current.secondaryColor)) {
                        VStack {
                            
                            Picker("", selection: $isToday) {
                                Text("Today")
                                    .font(.headline)
                                    .foregroundColor(themeSc.current.primaryColor)
                                    .tag(Formday.today)

                                Text("Tomorrow")
                                    .font(.headline)
                                    .foregroundColor(themeSc.current.primaryColor)
                                    .tag(Formday.tomorrow)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .onChange(of: isToday, perform: { newValue in
                                changeTheHours()
                            })
                            .onAppear {
                                UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(themeSc.current.primaryColor)
                                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor(themeSc.current.primaryColor)], for: .normal)
                                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor(themeSc.current.baseColor)], for: .selected)
                            }
                            
                            
                            Toggle(isOn: $reminderActive) {
                                Text("Activate Reminder")
                                    .font(.callout)
                                    .foregroundColor(themeSc.current.primaryColor)
                            }
                            .toggleStyle(.switch)
                            .tint(themeSc.current.primaryColor)
                            
                            HStack {
                                    Spacer()
                                    Picker("Select Hour", selection: self.$hourSelection) {
                                        ForEach(startHours ..< self.hours.count, id: \.self) { index in
                                            Text("\(self.hours[index])")
                                                .font(.headline)
                                                .foregroundColor(themeSc.current.primaryColor)
                                                .tag(index)

                                        }
                                    }
                                    .pickerStyle(WheelPickerStyle())
                                    .frame(width: 100, height: 100)
                                    .clipped()
                                    
                                    Picker("Select Minutes", selection: self.$minuteSelection) {
                                        ForEach(startMinutes ..< self.minutes.count, id: \.self) { index in
                                            Text("\(self.minutes[index])")
                                                .font(.headline)
                                                .foregroundColor(themeSc.current.primaryColor)
                                                .tag(index)
                                        }
                                    }
                                    .pickerStyle(WheelPickerStyle())
                                    .frame(width: 100, height: 100)
                                    .clipped()
                                
                                    Spacer()
                                }
                        }
                    }
                    .listRowBackground(themeSc.current.secondaryColor.opacity(0.1))
                    
                    Section {
                        Button {
                            save()
                        } label : {
                            Text("Save")
                                .fontWeight(.bold)
                                .textCase(.uppercase)
                                .font(.callout)
                                .foregroundColor(Color.green)
                        }
                        
                        Button() {
                            presentationMode.wrappedValue.dismiss()
                        } label : {
                            Text("Cancel")
                                .fontWeight(.bold)
                                .textCase(.uppercase)
                                .font(.callout)
                                .foregroundColor(Color.red)
                        }

                    }
                    .listRowBackground(themeSc.current.secondaryColor.opacity(0.1))
                }
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
                .foregroundColor(themeSc.current.primaryColor)
                .background(themeSc.current.baseColor)
            }
            .background(themeSc.current.baseColor)
            .navigationBarHidden(true)
            
        }

    }
    
    func changeTheHours() {
        if isToday == .today {
            let dateTime: Date = .now
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "HH"
            if let hh = Int(dateFormatter.string(from: dateTime)) {
                startHours = hh
            }
            
            dateFormatter.dateFormat = "mm"
            if let mm = Int(dateFormatter.string(from: dateTime)) {
                startMinutes = mm
            }
            
            hourSelection = startHours
            minuteSelection = startMinutes
        }
    }
    
    func dateToSave() -> Date {
        let dateTime: Date = .now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        if isToday == .today {
            
            let strDate = "\(dateFormatter.string(from: dateTime)) \(hourSelection):\(minuteSelection)"

            dateFormatter.dateFormat = "MMM d, yyyy HH:mm"
            guard let date = dateFormatter.date(from: strDate) else { return .now }

            return date
        } else {
            guard let modifiedDate = Calendar.current.date(byAdding: .day, value: 1, to: dateTime) else { return .now }
            
            let strDate = "\(dateFormatter.string(from: modifiedDate)) \(hourSelection):\(minuteSelection)"
            
            dateFormatter.dateFormat = "MMM d, yyyy HH:mm"
            guard let date = dateFormatter.date(from: strDate) else { return .now }
            
            return date

        }
    }
    
    func save() {
        let todo = Todo(context: viewContext)
        todo.id = UUID()
        todo.title = newTodoTitle
        todo.done = false
        todo.alert = reminderActive
        todo.time = dateToSave()
        todo.toDelete = false
        
        if reminderActive {
            setNotification()
        }
        
        try? viewContext.save()
        
        newTodoTitle = ""
        presentationMode.wrappedValue.dismiss()
    }
    
    func setNotification() {
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder to do things for yo!"
        content.body = newTodoTitle
        content.categoryIdentifier = NotificationCategory.general.rawValue
        content.userInfo = ["customData": "Some Data"]
        content.sound = .default
        content.badge = 1

        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateToSave())
        dateComponents.hour = hourSelection
        dateComponents.minute = minuteSelection
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        
        let dimiss = UNNotificationAction(identifier: NotificationAction.dismiss.rawValue, title: "Dismiss", options: [])
        let reminder = UNNotificationAction(identifier: NotificationAction.reminder.rawValue, title: "Reminder", options: [])
        let generalCategory = UNNotificationCategory(identifier: NotificationCategory.general.rawValue, actions: [dimiss, reminder], intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([generalCategory])
        
        center.add(request) { error in
            if let error = error {
                print(error)
            }
        }
        
        printNotifications()
    }
    
    ///Prints to console schduled notifications
    func printNotifications(){
        print(#function)
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getPendingNotificationRequests { request in
            for req in request{
                if req.trigger is UNCalendarNotificationTrigger{
                    print((req.trigger as! UNCalendarNotificationTrigger).nextTriggerDate()?.description ?? "invalid next trigger date")
                }
            }
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(ThemeSource())

    }
}
