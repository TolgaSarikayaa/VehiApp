//
//  MyCarApp.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 01.01.24.
//

import SwiftUI
import CoreData

@main
struct MyCarApp: App {
    @StateObject private var dataController = DataModelController.shared
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true
    var body: some Scene {
        WindowGroup {
            if isFirstLaunch {
                ContentView()
            } else {
                MainCV()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .onAppear() {
                        requestNotificationPermission()
                    }
            }
        }
    }
}
