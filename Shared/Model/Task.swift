//
//  Task.swift
//  Reminders
//
//  Created by Salvarajah, Prajina on 2022-01-20.
//

import Foundation

struct Task: Identifiable {
    
    var id = UUID()
    var description: String
    var priority: TaskPriority
    var completed: Bool
}

let testData = [

    Task(description: "Grow long hair", priority: .high, completed: true),
    Task(description: "eat lunch", priority: .medium, completed: false),
    Task(description: "do university supplements", priority: .low, completed: false),
    
]
