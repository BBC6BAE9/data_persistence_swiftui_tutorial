//
//  iCaloriesApp.swift
//  iCalories
//
//  Created by henry on 2023/9/18.
//

import SwiftUI

@main
struct iCaloriesApp: App {
    
    @State private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
    
}
