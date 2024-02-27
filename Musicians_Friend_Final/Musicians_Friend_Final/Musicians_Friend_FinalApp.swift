//
//  Musicians_Friend_FinalApp.swift
//  Musicians_Friend_Final
//
//  Created by Gibney, Melissa on 12/3/23.
//

import SwiftUI

@main
struct Musicians_Friend_FinalApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LaunchScreenView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
