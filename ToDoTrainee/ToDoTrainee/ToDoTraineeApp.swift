//
//  ToDoTraineeApp.swift
//  ToDoTrainee
//
//  Created by Kostiantyn Kaniuka on 08.12.2022.
//

import SwiftUI

@main
struct ToDoTraineeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DataStore())
        }
    }
}
