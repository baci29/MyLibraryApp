//
//  MyLibraryAppApp.swift
//  MyLibraryApp
//
//  Created by Radovan Bačík on 12.04.2025.
//

import SwiftUI

@main
struct MyLibraryApp: App {
    @StateObject private var viewModel = LibraryViewModel() 

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
