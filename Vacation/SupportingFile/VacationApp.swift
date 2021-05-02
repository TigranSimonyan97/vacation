//
//  VacationApp.swift
//  Vacation
//
//  Created by Tigran Simonyan on 5/2/21.
//

import SwiftUI

@main
struct VacationApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
