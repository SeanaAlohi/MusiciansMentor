//
//  TapTempo.swift
//  Metronome
//
//  Created by Majewski, Connor on 12/2/23.
//

import Foundation
import SwiftUI
import TapTempoButton

struct TapTempo: View{
    
    // Local variables to store information about metronome
    
    @State private var tempo: Double = 60
    @State private var isStart = false
    @State private var timeSignature: String = "4/4"
    @State private var startButtonEnabled = false
    
    let timeSignatures = ["2/4", "3/4", "4/4"]

    let metronome = Metronome()
    
    var body: some View {
    
        VStack(){
            
            // TapTempo Button.
            
            TapTempoButton(onTempoChange: onTempoChange) {
                
                isStart ? Text(String((Int(tempo)))).foregroundColor(Color("Blue"))
                     : Text("Tap").foregroundColor(Color("Blue"))
                
            }
            .font(.system(size: 64))
        
            .frame(width: 200, height: 300)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color("Blue"), lineWidth: 2))
            .padding(.bottom, 100)
            
            // Time Signature Button.
            
            VStack(){

                Picker("Time Signature", selection: $timeSignature) {
                    ForEach(timeSignatures, id: \.self) {
                        time in Text((time))
                    }
                }
                .pickerStyle(.menu)
                    .background(Color.white)
                    .cornerRadius(5)
                    .accentColor(Color("Blue")) // <- deprecated

            }
            .frame(width: 200, height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color("Blue"), lineWidth: 2)
            )
            
            // Start Button.
            
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
            
        }.frame(maxHeight: .infinity, alignment: .bottom)
        
    }
    
    func onTempoChange(_ tempo: Double){
        
        isStart = true
        self.tempo = tempo
        metronome.setTempo(newTempo: Int(tempo))
    }
    
    func getTempo() -> Int{
        
        return Int(tempo)
        
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
