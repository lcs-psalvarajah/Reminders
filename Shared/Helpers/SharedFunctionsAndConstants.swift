//
//  SharedFunctionsAndConstants.swift
//  Reminders
//
//  Created by Salvarajah, Prajina on 2022-01-26.
//

import Foundation

// Return the directory that we can save user data

func getDocumentDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

//Define a file label (or file name) that we will write to within hat directory
let savedTaskLabel = "savedTasks"
