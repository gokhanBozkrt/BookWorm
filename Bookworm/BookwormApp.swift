//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Gokhan Bozkurt on 12.05.2022.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
        ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}


// .environment(\.managedObjectContext,dataController.container.viewContext)
