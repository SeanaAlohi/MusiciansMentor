//
//  Tuner.swift
//  MusiciansFriend
//
//  Created by Nazario, Mariela on 11/9/23.
//

import SwiftUI
import AVFoundation
import AudioKit
import SoundpipeAudioKit
import AudioKitEX
import AudioToolbox

struct TunerData {
    
    var pitch: Float = 0.0
    var noteSharpe = "-"
    var noteFlats = "_"
    var freqDistance: Float = 0.0
   
}



class Tuner: ObservableObject{
    @Published var data = TunerData()
    @Published var current_color: String
    @Published var current_note: String

    let frequencies = [16.35,17.32,18.35,19.45,20.60,21.83,23.12,24.50,25.96,27.50,29.14,30.87]
    let noteWithSharps = ["C","C#","D","D#","E","F","F#","G","G#","A","A#","B"]
    let noteFlats = ["C","Db","Eb","E","F","Gb","G","Ab","A","Bb","B"]
     
  
    
    
    
    let fileUR = URL(string: "Users/mnazari2/Desktop/recording.wav")
   
    
    //let audioEngine = AudioEngine()
    var identifier:  PitchTap!
    //let audioEngine = AVAudioEngine()
    let playerNode = AVAudioPlayerNode()
    let audioPlayer: AudioPlayer
    let engine = AudioEngine()
    let silence: Fader
    let nodeA : Fader
    let nodeB: Fader
    let nodeC: Fader
    
    init(){
        current_note = noteWithSharps[0]
        current_color = "Red"
        audioPlayer = AudioPlayer()
        nodeA = Fader(audioPlayer)
        nodeB = Fader(nodeA)
        nodeC = Fader(nodeB)
        silence = Fader(nodeC, gain: 0)
        engine.output = silence
        
        identifier = PitchTap(audioPlayer){ pitch, amp in
            DispatchQueue.main.async{
                self.detect(pitch[0])
            }
        }
        identifier.start()
        
    }
    
    func loadandstart(_ url: URL){
        guard let audioFile = try? AVAudioFile(forReading: url) else { return }
                do{
                   try audioPlayer.load(file: audioFile)
                    audioPlayer.completionHandler = { [weak self] in
                         
                        self?.stop()
                        print("stopping load and start")
                        
                    }
                    audioPlayer.start()
                
                   
               } catch let error {
                   print(error)
               }
    }
    
    func stop(){
        audioPlayer.stop()
        engine.stop()
        print("stopping audioplayer and engine")
    }
    

    func start(_ url: URL){
        do{
            try engine.start()
            print("audio engine started")
            loadandstart(url)
        } catch{
            print("cannot start")
        }
        
    }
    
    func detect(_ pitch: AUValue){
        let minPitch: AUValue =  40.0
        let maxPitch: AUValue =  1200.0
        data.pitch = pitch
        

        guard pitch >= minPitch else { return }
        guard pitch <= maxPitch else { return }
        // adjust the pitch to be on frequency range
        
        var freq = pitch
     
        
        while(freq > 30.87 ){
            freq = freq / 2.0
        }
        
        while(freq < 16.35){
            freq = freq * 2.0
        }
       
        //get frequency
        
        var minDistance: Float = 10000.0
        var index = 0
        
        // finding the min frequency
        for i in 0 ..< frequencies.count {
            let distance = fabsf(Float(frequencies[i]) - freq)
            
            if distance < minDistance{
                index = i
                minDistance = distance
//                print("This is the index", index)
//                print("this is the mindistance", minDistance)
            }
        }
        
        //determine how far or close the user is to the correct note
        print(minDistance)
        current_note = noteWithSharps[index]
//        print("This is the current note", current_note)
        
     
        if minDistance < 1 {
            current_color = "Green"
        }
        else if minDistance < 5{
            current_color = "Yellow"
        }
        else{
            current_color = "Red"
        }
        
//        let octave = Int(log2f(pitch / freq ))
//        data.noteSharpe = "\(noteWithSharps[index])\(octave)"
//      //  data.noteFlats  = "\(noteFlats[index])\(octave)"
//        print(current_note)
        
        
    }
    
    func get_color() -> Color?{
        switch current_color{
        case "Red": return Color.red
        case "Green": return Color.green
        case "Yellow": return Color.yellow
            
        default:
            return Color.red
        }
    }
    
    func get_currentNote() -> String{
        return current_note
    }
   
}
