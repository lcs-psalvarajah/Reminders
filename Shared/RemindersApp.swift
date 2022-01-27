//
//  RemindersApp.swift
//  Shared
//
//  Created by Salvarajah, Prajina on 2022-01-20.
//

import SwiftUI

@main
struct RemindersApp: App {
    
    // Detect when app moves between the foreground, background, and inactive states
    @Environment(\.scenePhase) var scenePhase
    
    
    // CReate the source of truth for our list of tasks (create the view model)
    @StateObject private var store = TaskStore(tasks: testData)
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(store: store)
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive {
                print("Inactive")
            } else if newPhase == .active {
                
                print("Active")
                
            } else if newPhase == .background {
                print("Background")
                
                // Permanently save the list of tasks
                store.persistTasks()
            }
        }
    }
}
