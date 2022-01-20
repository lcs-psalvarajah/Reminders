//
//  Task.swift
//  Reminders
//
//  Created by Salvarajah, Prajina on 2022-01-20.
//

import Foundation

class Task: Identifiable, ObservableObject {

    var id = UUID()
    var description: String
    var priority: TaskPriority
    @Published var completed: Bool
    
    internal init(id: UUID = UUID(), description: String, priority: TaskPriority, completed: Bool) {
        self.id = id
        self.description = description
        self.priority = priority
        self.completed = completed
    }
}

let testData = [

    Task(description: "Grow long hair", priority: .high, completed: true),
    Task(description: "eat lunch", priority: .medium, completed: false),
    Task(description: "do university supplements", priority: .low, completed: false),
    
]
