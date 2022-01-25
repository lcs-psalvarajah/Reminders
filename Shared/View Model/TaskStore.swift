//
//  TaskStore.swift
//  Reminders
//
//  Created by Salvarajah, Prajina on 2022-01-20.
//

import Foundation

class TaskStore: ObservableObject {
    // MARK: Stored properties
    @Published var tasks: [Task]
    
    // MARK: Initializers
    init(tasks: [Task] = []) {
        self.tasks = tasks
    }
    
    // MARK: Functions
    func deleteItems(at offsets: IndexSet) {
        // "offsets" contain a set of items elescted for deletion
        // The set is then passed to the built-in "remove" method on
        // the "tasks" array which handles removal from the array
        tasks.remove(atOffsets: offsets)
    }
}

let testStore = TaskStore(tasks: testData)
