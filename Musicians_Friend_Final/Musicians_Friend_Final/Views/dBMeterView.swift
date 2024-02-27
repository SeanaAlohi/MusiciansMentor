//
//  dBMeterView.swift
//  MusiciansFriend
//
//  Created by Melissa Gibney on 12/2/23.
//

import SwiftUI
import AVFoundation
import AudioKit
import UIKit

struct dBMeterView: View {
    
    @StateObject var recorder = Recorder()
    @State var showAlert = false
    var timer: Timer!
    var body: some View {
        
        //let dBMeterInst = dBMeter.init()
        
        
        VStack{
            //Add the dB Meter and labels above the scroll view
            HStack{
                //Labels for instantaneous dB and average dB
                VStack{
                    Text(String(dBFSTodBSPL(dBFS: recorder.peakDB)))
                        .font(.system(size: 20))
                        .foregroundColor(Color("Blue"))
//                    Text(String($recorder.peakDB.wrappedValue))
                    Text("Instantaneous dBFS")
                        .font(.system(size: 15))
                        .foregroundColor(Color("Blue"))
                    Text("")
                    Text(String(dBFSTodBSPL(dBFS: recorder.averageDB)))
                        .font(.system(size: 20))
                        .foregroundColor(Color("Blue"))
//                    Text(String($recorder.averageDB.wrappedValue))
                    Text("Average dBFS")
                        .font(.system(size: 15))
                        .foregroundColor(Color("Blue"))
                }.padding(20)
                Text("                ")
                //Meter
                VStack{
                    ZStack{
                        var enclosingRect = Rectangle()
                        enclosingRect.scaledToFit()
                        enclosingRect.foregroundColor(Color(uiColor: UIColor.white))
                        var myRect = RoundedRectangle(cornerRadius: 10)
                        myRect.foregroundColor(Color("Blue")).frame(width: 50, height: 200*CGFloat(((dBFSTodBSPL(dBFS: recorder.peakDB)+150)/200)))
                    }
                    
                    
                    Text("dBFS Meter")
                        .font(.system(size: 20))
                        .foregroundColor(Color("Blue"))
                }
            }

//            Text("")
            Text("")
            Text("")
            Text("")
            Text("Noise Level Examples")
                .font(.system(size: 15))
                .foregroundColor(Color("Blue"))
            HStack{
                Text("     Decibels (dBSPL)")
                    .font(.system(size: 15))
                    .foregroundColor(Color("Blue"))
                    .padding(5)
                Text("Example Sound")
                    .font(.system(size: 15))
                    .foregroundColor(Color("Blue"))
                    .padding(5)
                Text("Safe Exposure Time")
                    .font(.system(size: 15))
                    .foregroundColor(Color("Blue"))
                    .padding()
            }
            //Scroll view for dangerous dB Levels
            ScrollView{
                VStack{
                    Group{
                        //Every entry goes in an HStack
                        HStack{
                            Text("0dB ")
                            Text("    Threshold of Hearing")
                            Text("       Infinite")
                                
                        }
                        
                        
                        HStack{
                            Text("10dB        ")
                            Text(" Breathing")
                            Text("                     Infinite")
                        }
                        
                        
                        HStack{
                            Text("20dB               ")
                            Text("Whisper")
                            Text("               Infinite")
                        }
                        
                        
                        HStack{
                            Text("30dB           ")
                            Text("Quiet Library")
                            Text("           Infinite")
                        }
                        
                        
                        HStack{
                            Text("40dB    ")
                            Text("Quiet Neighborhood")
                            Text("     Infinite")
                        }
                        
                    }
                    Group{
                        HStack{
                            Text("50dB   ")
                            Text("Normal Conversation")
                            Text("     Infinite")
                        }
                        HStack{
                            Text("60dB           ")
                            Text("TV @ 1 Meter")
                            Text("           Infinite")
                        }
                        HStack{
                            Text("70dB   ")
                            Text("Vaccuum Cleaner")
                            Text("            Infinite")
                        }
                        HStack{
                            Text("  80dB   ")
                            Text("Washing Machine")
                            Text("          16 Hours")
                        }
                        HStack{
                            Text("  85dB    ")
                            Text("Proper Listening for Recording/Mixing")
                            Text("     12 Hours")
                        }
                    }
                    Group{
                        HStack{
                            Text(" 90dB             ")
                            Text("Power Drill")
                            Text("             8 Hours")
                        }
                        HStack{
                            Text("100dB   ")
                            Text("iPhone at Full Volume")
                            Text("   2 Hours")
                        }
                        HStack{
                            Text("  110dB             ")
                            Text("Car Race")
                            Text("               1/2 Hour")
                        }
                        HStack{
                            Text("     120dB         ")
                            Text("Loud Rock Concert")
                            Text("       <60 Minutes, Damage Occurring")
                        }
                        HStack{
                            Text("        130dB     ")
                            Text("Police Siren")
                            Text("     Ear Drum Distortion")
                        }
                    }
                }.font(.system(size: 15))
                    .onAppear {
                    recorder.microphoneAccess()
                    
                    let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){_ in
                        print("Timer Init")

                        if recorder.shouldShowAlert(){
                            showAlert = true
                        }
                    }
                }
                .onDisappear{
                    recorder.stopRecording()
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Possible Dangerous Noise Level"),
                    message: Text("You are currently experiencing dangerous noise levels.  You may want to use ear plugs to avoid hearing damage."),
                    dismissButton: .default(Text("OK")))
            }
        }
  
    }
}

func dBFSTodBSPL(dBFS: Float) -> Float
{
    return dBFS//20*log10f(5.0*powf(10.0, (dBFS/20))*160) + 50
}

func showNoiseLevelAlert()
{
    //Create the Alert
    let noiseAlert = UIAlertController(title: "Dangerous Noise Level", message: "You are currently experiencing dangerous noise levels.  You may want to use ear plugs to avoid hearing damage.", preferredStyle: .alert)
    noiseAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
    //Show the alert
    //body.presentView(noiseAlert)
    //noiseAlert.show(getCurrentViewController(), sender: nil)
}


struct dBMeterView_Previews: PreviewProvider {
    static var previews: some View {
        dBMeterView()
    }
}
