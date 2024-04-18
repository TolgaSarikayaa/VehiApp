//
//  MyCarApp.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 01.01.24.
//

import SwiftUI
import CoreData
import TipKit

@main
struct MyCarApp: App {
    @StateObject private var dataController = DataModelController.shared
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true
    @StateObject private var colorManager = ColorManager()
    var body: some Scene {
        WindowGroup {
            if isFirstLaunch {
                ContentView()
            } else {
                MainCV()
                    .environmentObject(colorManager)
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .onAppear() {
                        requestNotificationPermission()
                    }
                    .task {
                        try? Tips.configure([
                            .displayFrequency(.immediate),
                            .datastoreLocation(.applicationDefault)
                        ])
                    }
            }
        }
    }
}
