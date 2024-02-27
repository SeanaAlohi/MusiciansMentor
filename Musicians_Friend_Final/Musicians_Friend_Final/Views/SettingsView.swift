//
//  SettingsView.swift
//  Metronome
//
//  Created by Majewski, Connor on 11/4/23.
//

import SwiftUI
//import Foundation

struct SettingsView: View {
    @AppStorage("Username") var username = ""
    @AppStorage("Email") var email = ""
    @AppStorage("Instrument") var instrument = 0
    @AppStorage("CustomInstrument") var custInstrument = ""
    
    var body: some View {
        
        NavigationView{
            Form {
                Section(header: Text("Your Info")) {
                    TextField("Username", text: $username)
                }
                
                Section(header: Text("Email Address")) {
                    TextField("Email", text: $email)
                }
                
                Picker(selection: $instrument, label: Text("Instrument")) {
                    Text("Piano").tag(0)
                    Text("Guitar").tag(1)
                    Text("Drums").tag(2)
                    Text("Bass").tag(3)
                    Text("Violin").tag(4)
                    Text("Flute").tag(5)
                    }
                .pickerStyle(.wheel)
                
                Section(header: Text("Custom Instrument")) {
                    TextField("Custom Instrument", text: $custInstrument)
                }
                }
            
            }.navigationBarTitle("Settings")
    }
    }


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
