//
//  Pomodoro_trialApp.swift
//  Pomodoro-trial
//
//  Created by DarkBringer on 18.06.2021.
//

import SwiftUI

@main
struct Pomodoro_trialApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainPage()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
