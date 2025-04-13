//
//  SettingsView.swift
//  MyLibraryApp
//
//  Created by Radovan Bačík on 12.04.2025.
//
import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false 

    var body: some View {
        Form {
            Section(header: Text("Vzhled")) {
                Toggle("Tmavý režim", isOn: $isDarkMode)
            }

            Section(header: Text("Informace")) {
                Text("Verze aplikace: 1.0")
                Text("Vývojář: Radovan Bačík")
            }
        }
        .navigationTitle("Nastavení")
    }
}

    
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
