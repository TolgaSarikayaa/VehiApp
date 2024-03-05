//
//  MyCarApp.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 01.01.24.
//

import SwiftUI
import SwiftData

@main
struct MyCarApp: App {
    @StateObject private var dataController = GasModelController()
    var body: some Scene {
        WindowGroup {
            MainCV()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .onAppear() {
                    requestNotificationPermission()
                }
        }
    }
}
