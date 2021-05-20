//
//  duri_moodApp.swift
//  duri-mood
//
//  Created by 김두리 on 2021/05/20.
//

import SwiftUI

@main
struct duri_moodApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
