//
//  myThingunApp.swift
//  myThingun
//
//  Created by Taewan Kim on 2022/01/19.
//

import SwiftUI

@main
struct myThingunApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ThingunTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
