//
//  ContentView.swift
//  Shared
//
//  Created by Salvarajah, Prajina on 2022-01-20.
//

import SwiftUI

struct ContentView: View {
    
    //Stores all tasks that are being tracked
    @ObservedObject var store: TaskStore
    
    //Controls whether the add task is showing
    @State private var showingAddTask = false
    
    //Whether to show completed tasks or not
    @State var showingCompletedTasks = true
    
    // What priority of tasks to show
    @State private var selectedPriorityForVisibleTasks: VisibleTaskPriority = .all
    
    //Whether to re-compute the view to show changes the list
    // We never actually show this value, but toggling it
    // from "true" to "false" or vice-versa makes SwiftUi update
    // the user interface, since the property mark with @State has
    // changed
    @State var listShouldUpdate = false
    
    var body: some View {
        
        // Has the list been asked to update?
        let _ = print("listShouldUpdate has been toggled. Current value is: \(listShouldUpdate)")
        
        VStack {
            
            // Label for picker
            Text("Filter by...")
                .font(Font.caption.smallCaps())
                .foregroundColor(.secondary)
            
            //Picker to allow user to select which tasks to show
            Picker("Priority", selection: $selectedPriorityForVisibleTasks) {
                Text(VisibleTaskPriority.all.rawValue)
                    .tag(VisibleTaskPriority.all)
                Text(VisibleTaskPriority.low.rawValue)
                    .tag(VisibleTaskPriority.low)
                Text(VisibleTaskPriority.medium.rawValue)
                    .tag(VisibleTaskPriority.medium)
                Text(VisibleTaskPriority.high.rawValue)
                    .tag(VisibleTaskPriority.high)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            List {
                ForEach(store.tasks) { task in
                    
                    // dont have to put == true since showingCompletedTasks is a boolean
                    if showingCompletedTasks {
                        
                        if selectedPriorityForVisibleTasks == .all {
                            //show all tasks, all priorities
                            TaskCell(task: task, triggerListUpdate: .constant(true))
                        } else {
                            
                            //Only show tasks of the selected priority
                            //Althrough "priority" and "selectedPriorityForVisibleTasks" are different data
                            // types (different enumerations) this works because we are comparing their
                            // raw values, which are both of type String
                            if task.priority.rawValue == selectedPriorityForVisibleTasks.rawValue {
                                TaskCell(task: task, triggerListUpdate: .constant(true))
                            }
                        }
                        
                    } else {
                        
                        // Only show incompleted tasks
                        if task.completed == false {
                            
                            if selectedPriorityForVisibleTasks == .all {
                                // show all completed tasks, only for selected priority level
                                TaskCell(task: task, triggerListUpdate: $listShouldUpdate)
                                
                            }
                        }
                        
                    }
                    
                }
                
                // View modifier invokes the function on the view model, "store"
                .onDelete(perform: store.deleteItems)
                .onMove(perform: store.moveItems)
            }
            
            .navigationTitle("Reminders")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add") {
                        showingAddTask = true
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .bottomBar) {
                    // Allow user to toggle visibility of tasks based on their completion status
                    //
                    // CONDITION TO EVALUATE          WHEN TRUE                 WHEN FALSE
                    Button(showingCompletedTasks ? "Hide Completed Tasks" : "Show Completed Tasks") {
                        print("Value of showingCompletedTasks was: \(showingCompletedTasks) ")
                        showingCompletedTasks.toggle()
                        print("Value of showingCompletedTasks now: \(showingCompletedTasks) ")
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTask(store: store, showing: $showingAddTask)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView(store: testStore)
            
        }
    }
}
