//
//  Metronome.swift
//  Metronome
//
//  Created by Majewski, Connor on 12/1/23.
//

import Foundation
import AVFoundation

// Two audio players for strong and weak beats of metronome

let audioPlayer = AudioPlayerHelper.shared
let audioPlayerStrong = AudioPlayerHelper.shared

class Metronome{
    
    var tempo = 60
    var enabled: Bool = false
    var index = 1;
    var timeSignature = 4
    
    var currentTick: ((_ nextTick: DispatchTime) -> Void)?
    var nextTick : DispatchTime = DispatchTime.distantFuture
    
    // audio files for metronome
    
    let soundSource = Bundle.main.url(forResource: "sound/metronome", withExtension: "mp3")!
    let soundSourceStrong = Bundle.main.url(forResource: "sound/metronomestrong", withExtension: "mp3")!
    
    func start() {
    
        // set one of two audioplayers to play based on next beat
        
        audioPlayer.prepareToPlay()
        audioPlayerStrong.prepareToPlay()
        nextTick = DispatchTime.now()
        metronomeTick()
    
    }
    
    func stop(){
        
        audioPlayer.stop()
        audioPlayerStrong.stop()
        
    }
    
    func metronomeTick(){
        
        guard
            enabled,
            nextTick <= DispatchTime.now()
        else { return }
        let interval: TimeInterval = 60.0 / TimeInterval(tempo)
        nextTick = nextTick + interval
        DispatchQueue.main.asyncAfter(deadline: nextTick) { [weak self] in self?.metronomeTick()}
        index == 1 ? audioPlayer.play(url: soundSource, atTime: interval) : audioPlayerStrong.play(url: soundSourceStrong, atTime: interval)
        currentTick?(nextTick)
        index = (index + 1) % timeSignature
    }
    
    // Helper functions to modify and set attributes of Metronome class.
    
    func setTempo(newTempo: Int){
     
        tempo = newTempo
        
    }
    
    func setEnabled(){
        
        enabled = !enabled
        
    }
    
    func incrementTempo(){
        
        tempo += 5
        
    }
    
    func decrementTempo() {
        
        tempo -= 5
        
    }
    
    func setTimeSignature(newTimeSignature: Int) {
        
        timeSignature = newTimeSignature
        
    }
    
    func resetIndex(){
        
        index = 1
        
    }
    
}

// Helper class to ensure AVAudioPlayers are persistent even outside of local class functions.

class AudioPlayerHelper {
    
    static let shared = AudioPlayerHelper()
    
    var audioPlayer: AVAudioPlayer?
    
    func play(url: URL, atTime: TimeInterval){
        
        do {
            
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            audioPlayer?.play()
            
        }
        
        catch let error {
            print("\(error)")
            
        }
        
    }
    
    func stop(){
        
        audioPlayer?.stop()
        
    }
    
    func prepareToPlay(){
        
        audioPlayer?.prepareToPlay()
        
    }
    
}




