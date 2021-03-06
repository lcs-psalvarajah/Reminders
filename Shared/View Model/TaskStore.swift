//
//  TaskStore.swift
//  Reminders
//
//  Created by Salvarajah, Prajina on 2022-01-20.
//

import Foundation
import SwiftUI

class TaskStore: ObservableObject {
    // MARK: Stored properties
    @Published var tasks: [Task]
    
    // MARK: Initializers
    init(tasks: [Task] = []) {

        //Get a URL that points to the saved JSON data containing our list of tasks
        let filename = getDocumentDirectory().appendingPathComponent(savedTaskLabel)
        print(filename)
        
        // Attempt to load from the JSON in the stored / persisted file
        do {
            // Load the raw data
            let data = try Data(contentsOf: filename)
            
            //What was loaded from the file?
            print("Got data from the file, contents are:")
            print(String(data: data, encoding: .utf8)!)
            
            //Decode the data into Swift native data structures
            self.tasks = try JSONDecoder().decode([Task].self, from: data)
            
        } catch  {
            //What went wrong?
            print(error.localizedDescription)
            print("Could not load data from file, initializing with tasks provided to initializer")
            
            //Set up list of tasks to whatever was passed to this initializer
            self.tasks = tasks
        }

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
    
    func persistTasks() {
        
        //Get a URL that points to the saved JSON data containing our list of tasks
        let filename = getDocumentDirectory().appendingPathComponent(savedTaskLabel)
        
        //Try to encode the data in our people array to JSON
        do {
            
            // Create an encoder
            let encoder = JSONEncoder()
            
            //Ensure the JSON written to the file is human-readable
            encoder.outputFormatting = .prettyPrinted
            
            //Encode the lists of tasks we've collected
            let data = try encoder.encode(self.tasks)
            
            //Actually write the JSON file to the documents directory
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            
            // see the data that was written
            print("Saved data to documents directory successfully.")
            print("===")
            print(String(data: data, encoding: .utf8)!)

        } catch  {
            print(error.localizedDescription)
            print("Unable to write list of tasks to documents of directory in app bundle on device.")
        }
        
    }
    
}

let testStore = TaskStore(tasks: testData)
