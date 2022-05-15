//
//  TestairApp.swift
//  Testair
//
//  Created by Ionut Macovei on 15.05.2022.
//

import SwiftUI

@main
struct TestairApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}