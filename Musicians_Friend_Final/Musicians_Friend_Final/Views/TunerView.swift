//
//  TunerView.swift
//  MusiciansFriend
//
//  Created by Nazario, Mariela on 12/1/23.
//

import SwiftUI

struct TunerView: View {
    
    @StateObject var tuner_instance = Tuner()
    @StateObject var recorder = Recorder()
    
    var body: some View {
        
        VStack{
            
            Circle()
                .stroke(tuner_instance.get_color() ?? Color.black,lineWidth: 8)
                .frame(width:330,height:300)
                .overlay(
                    Text(tuner_instance.get_currentNote())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.teal)
                    
                )
                .onAppear {
                    let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){_ in
                        print("Timer Init")
                        recorder.TunerMicAcess()
                        print("microphone access starting")
                        tuner_instance.start(recorder.returnURL())
                        print("tuner instance started")
                        tuner_instance.start(recorder.returnURL())
                    }
                }
                .onDisappear{
                    recorder.stopRecording()
                    print("recording stopped")
                    tuner_instance.stop()
                    print("tuner instance stopped")
                }
        }
    }
}
    


struct TunerView_Previews: PreviewProvider {
    static var previews: some View {
        TunerView()
    }
}
