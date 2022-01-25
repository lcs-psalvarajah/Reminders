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
    
    var body: some View {
        
        List {
            ForEach(store.tasks) { task in
                // dont have to put == true since showingCompletedTasks is a boolean
                if showingCompletedTasks {
                    // show all tasks, completed or incomplete
                    TaskCell(task: task)
                } else {
                    
                    // Only show incompleted tasks
                    if task.completed == false {
                        TaskCell(task: task)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView(store: testStore)

        }
    }
}
