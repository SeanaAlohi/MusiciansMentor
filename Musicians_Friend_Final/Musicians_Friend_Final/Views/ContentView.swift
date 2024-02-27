//
//  ContentView.swift
//  Musicians_Friend_Final
//
//  Created by Gibney, Melissa on 12/3/23.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        TabView{

                    TunerView().tabItem{(Label("Tuner", systemImage: "music.mic"))}

                    MetronomeView().tabItem{(Label("Metronome", systemImage: "metronome.fill"))}
                    
                    dBMeterView().tabItem{(Label("dBMeter", systemImage: "ear.fill"))}

                    ResourcesView().tabItem{(Label("Resources", systemImage: "doc.fill"))}

                    SettingsView().tabItem{(Label("Settings", systemImage: "gear"))}
                }
                .accentColor(Color("Blue"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
