//
//  Task.swift
//  Reminders
//
//  Created by Salvarajah, Prajina on 2022-01-20.
//

import Foundation
import SwiftUI

// Identify what properties should be read to and written from JSON
// NOTE: We are not encoding the "id" becuase it is not needed
//  New UUID values will be generated when the JSON file is read
// in the future

enum TaskCodingKeys: CodingKey {
    case description
    case priority
    case completed
}

class Task: Identifiable, ObservableObject, Codable {
    
    //MARK: Stored properties
    var id = UUID()
    var description: String
    var priority: TaskPriority
    @Published var completed: Bool
    
    //MARK: Initializers
    internal init(id: UUID = UUID(), description: String, priority: TaskPriority, completed: Bool) {
        self.id = id
        self.description = description
        self.priority = priority
        self.completed = completed
    }


// MARK: Functions

// Provide details for how to encode to JSON from an instance of this type
func encode(to encoder: Encoder) throws {
    
    // Create a container that will be used to write an instance of the Task type to JSON
    var container = encoder.container(keyedBy: TaskCodingKeys.self)
    
    //Everything is encoded into String types
    try container.encode(description, forKey: .description)
    try container.encode(priority.rawValue, forKey: .priority)
    try container.encode(completed, forKey: .completed)

}
    
    //Provide details for how to decode from JSON into an instance of this data type
    required init(from decoder: Decoder) throws {
        // Create a container that will be used to create an instance of the Task type when decoding from JSON
        let container = try decoder.container(keyedBy: TaskCodingKeys.self)
        
        //Decode "description" property into an instance of the String type
        self.description = try container.decode(String.self, forKey: .description)
        //Decode "priority" property into an instance of the TaskPriority type
        self.priority = try container.decode(TaskPriority.self, forKey: .priority)
        //Decode "completed" property into an instance of the Bool type
        self.completed = try container.decode(Bool.self, forKey: .completed)
    }
    
}


let testData = [
    
    Task(description: "Grow long hair", priority: .high, completed: true),
    Task(description: "eat lunch", priority: .medium, completed: false),
    Task(description: "do university supplements", priority: .low, completed: false),
    
]
