//
//  AddTask.swift
//  Reminders
//
//  Created by Salvarajah, Prajina on 2022-01-20.
//

import SwiftUI

struct AddTask: View {
    
    // Get a reference to the store of tasks (TaskStore)
    @ObservedObject var store: TaskStore
    
    //Details of he new task
    @State private var description = ""
    @State private var priority = TaskPriority.low
    
    //Whether to show this view
    @Binding var showing: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Description", text: $description)
                    
                    Picker("Priority", selection: $priority) {
                        Text(TaskPriority.low.rawValue).tag(TaskPriority.low)
                        Text(TaskPriority.medium.rawValue).tag(TaskPriority.medium)
                        Text(TaskPriority.high.rawValue).tag(TaskPriority.high)
                        
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("New Reminder")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        saveTask()
                    }
                    
                    // The button is disabled, and therefore cannot be
                    // pressed, when the description of the task is empty.
                    // This prevents the user from saving an empty task
                    .disabled(description.isEmpty)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        // Dismiss the sheet by adjusting the "showing"
                        // property, a derived value, which is bound
                        //to the "showingAddTask" property from
                        // ContentView, the source of truth
                        showing = false
                    }
                }
            }
        }
        
        //Prevents dismissal of the sheet by swiping down
        // If sheet is dismissed this way, data is not saved
        // Better that the user needs to press save button or cancel button
        // so we know their intent when dismissing the sheet
        .interactiveDismissDisabled()
        
    }
    
    func saveTask() {
        
        // Add the task to the list of tasks
        store.tasks.append(Task(description: description,
                                priority: priority,
                                completed: false))
        
        //Dismiss this view
        showing = false
        
    }
    
}

struct AddTask_Previews: PreviewProvider {
    static var previews: some View {
        AddTask(store: testStore, showing: .constant(true))
    }
}
