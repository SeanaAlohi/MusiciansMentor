//
//  MetronomeView.swift
//  Metronome
//
//  Created by Majewski, Connor on 11/4/23.
//

import SwiftUI
import Foundation
import AVFoundation

// This file contains the main view/tab for the metronome.
// There are two seperate metronomes seperated in a TabView.
// One metronome is based on user taps, and one is set manually.

struct MetronomeView: View {

    // Local variables used to modify Metronome Object
    
    @State private var isEnabled = false
    @State private var timeSignature: String = "4/4"
    @State private var tempo = 60
    @State private var startButtonEnabled = false
    
    let timeSignatures = ["2/4", "3/4", "4/4"]

    let tap = TapTempo()
    let metronome = Metronome()
    
    var body: some View {
        VStack(){
            
            // Tabview to store both TapTempo View and Metronome View
            
            TabView{
                
                // TapTempo View
                
                tap
                
                // Manual Metronome View
                
                VStack(){
                    
                    HStack(){
                        
                        Button(action: incrementTempo){

                            Text("+")
                                .font(.system(size: 55))
                                .foregroundColor(Color("Blue"))

                        }

                        Text(String(tempo))
                            .font(.system(size: 64))
                            .foregroundColor(Color("Blue"))
                        
                        Button(action: decrementTempo){

                            Text("-")
                                .font(.system(size: 64))
                                .foregroundColor(Color("Blue"))

                        }

                    }
                    .font(.system(size: 32))
                    .frame(width: 200, height: 300)
                    
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color("Blue"), lineWidth: 2))

                    .padding(.bottom, 100)
                    
                    
                    VStack(){

                        Picker("Time Signature", selection: $timeSignature) {
                            
                            ForEach(timeSignatures, id: \.self) {
                                time in Text((time))
                                
                            }
                            
                        }
                        .pickerStyle(.menu)
                            .background(Color.white)
                            .cornerRadius(5)

                    }
                    .frame(width: 200, height: 50)
                    
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color("Blue"), lineWidth: 2)
                    )
                    
                    Button(action: startMetronome){
                        
                        if !startButtonEnabled {
                            
                            Text("Start")
                                .font(.system(size: 24))
                                .frame(width: 200, height: 50)
                                .background(Color("Blue"))
                                .foregroundColor(Color.white)
                                .cornerRadius(30)
                                .padding(.bottom, 30)

                        }
                        
                        else {
                            
                            Text("Stop")
                                .font(.system(size: 24))
                                .frame(width: 200, height: 50)
                                .background(Color("Blue"))
                                .foregroundColor(Color.white)
                                .cornerRadius(30)
                                .padding(.bottom, 30)
                            
                        }
                        
                    }
                      
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                    
                }

            }
        .tabViewStyle(.page)
        
    }
    
    // Helper functions to modify local tempo variable and tempo variable in Metronome object
    
    func incrementTempo(){
        
        tempo += 5
        metronome.setTempo(newTempo: tempo)
        
    }
    
    func decrementTempo(){
        
        if(metronome.tempo > 1) {
            
            tempo -= 5
            metronome.setTempo(newTempo: tempo)

            
        }
    
        
    }
    
    // Function to modify and start metronome.
    
    func startMetronome(){
        
        print(metronome.tempo)

        metronome.setTimeSignature(newTimeSignature: Int(timeSignature.prefix(1))!)

        startButtonEnabled.toggle()

        metronome.resetIndex()
        
        metronome.setEnabled()
        
        metronome.enabled ? metronome.start() : metronome.stop()

    }
    
    
}

struct MetronomeView_Previews: PreviewProvider {
    static var previews: some View {
        MetronomeView()
    }
}
