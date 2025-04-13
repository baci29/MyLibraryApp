//
//  ContentView.swift
//  MyLibraryApp
//
//  Created by Radovan Bačík on 12.04.2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
            TabView {
                LibraryView()
                    .tabItem {
                        Image(systemName: "book.fill")
                        Text("Knihovna")
                    }
                
                AddBookView()
                    .tabItem {
                        Image(systemName: "plus.square")
                        Text("Přidat Knihu")
                    }
                
                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Nastavení")
                    }
            }
        .preferredColorScheme(isDarkMode ? .dark : .light) 
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LibraryViewModel()) 
    }
}

