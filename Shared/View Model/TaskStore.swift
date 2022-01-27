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
        // "offsets" contain a set of items selected for deletion
        // The set is then passed to the built-in "remove" method on
        // the "tasks" array which handles removal from the array
        tasks.remove(atOffsets: offsets)
    }
    
    //Invoked to move items around in the list
    func moveItems(from source: IndexSet, to destination: Int) {
        // "source" again contains a set of item(s) being moved
        // "destination" is the loction the items are being moved to in the list
        // These arguements are automatically populated for us by the
        // .onMove vie modifier provided by the swiftUi framework
        tasks.move(fromOffsets: source, toOffset: destination)
    }
}

let testStore = TaskStore(tasks: testData)
