//
//  TestairApp.swift
//  Testair
//
//  Created by Ionut Macovei on 15.05.2022.
//

import SwiftUI

@main
struct TestairApp: App {
    let persistenceManager = PersistenceManager.shared

    var body: some Scene {
        WindowGroup {
            let viewModel = HomeViewModel(with: persistenceManager.container.viewContext)
            HomeView(viewModel: viewModel)
                .environment(\.managedObjectContext, persistenceManager.container.viewContext)
        }
    }
}
