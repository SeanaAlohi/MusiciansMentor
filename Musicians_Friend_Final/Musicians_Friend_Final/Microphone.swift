//
//  Microphone.swift
//  MusiciansFriend
//
//  Created by Lanias, Seana Marie on 12/1/23.
//

import Foundation
import AVFoundation
import UIKit

class Recorder: ObservableObject {
    @Published var url: URL
    @Published var recorder: AVAudioRecorder?
    @Published var peakDB: Float
    @Published var averageDB: Float
    @Published var tooLoud: Bool
    @Published var userWasNotified: Bool //Tracks if the user was notified of the loud noise
    var timer: Timer!
    var audioFile: URL?

    init() {
         let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            let filePath = documentsDirectory.appendingPathComponent("recording.wav")
            audioFile = filePath
            self.url =  filePath
            self.peakDB = 0.0
            self.averageDB = 0.0
            self.tooLoud = false
            self.userWasNotified = false
            
            do {
                //generating recorder with url
                recorder = try AVAudioRecorder(url: url, settings: [:])
                print("recorder created")
            } catch {
                print("Error initializing AVAudioRecorder: \(error)")
            }
            
            let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){_ in
                print("Timer Init")
                self.updateMeters()
            }
        
    }
    func returnURL() -> URL {
        return audioFile!
    }
    
    // Additional initializers or methods can be added here
    //Getting recording access
    func createRecordingSession() {
        //Creating audio session
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
        } catch {
            print("Error occurred creating recording session.")
            return
        }
    }
    
    
    func startRecording(myRecorder : AVAudioRecorder)
    {
        myRecorder.record()
    }
    
    func stopRecording(myRecorder : AVAudioRecorder)
    {
        myRecorder.stop()
    }
    
//    func tunerLoop() {
//        while
//    }

    func recording() {
        guard let recorder = recorder else {
                    print("Recorder is not available")
                    return
                }
                // Start recording
                print("Try AVAudioRecorder successful")
                recorder.isMeteringEnabled = true
                recorder.record()
                print("Recording successful")
//                Thread.sleep(forTimeInterval: 2.0)
//                recorder.stop()
    }

    func tunerRecording() {
        guard let recorder = recorder else {
                    print("Recorder is not available")
                    return
                }
                // Start recording
                print("Try AVAudioRecorder successful")
                recorder.isMeteringEnabled = true
                recorder.record()
                print("Recording successful")
                Thread.sleep(forTimeInterval: 1.0)
                recorder.stop()
    }

    func updateMeters()
    {
        guard let recorder = recorder else {
            print("Recorder is not available")
            return
        }
        if(recorder.isRecording)
        {
            recorder.updateMeters()
            peakDB = recorder.peakPower(forChannel: 0)
            print("this the the peak power: ", peakDB)
            averageDB = recorder.averagePower(forChannel: 0)
            print("this the the average power: ", averageDB)
        }
    }
    
    func shouldShowAlert() -> Bool {
        if(peakDB > -1) {
            if(userWasNotified == false)
            {
                tooLoud = true
                userWasNotified = true;
            }
        }else {
            tooLoud = false
            userWasNotified = false;
        }//If noise is too loud and user was not notified, present the alert
        return tooLoud
    }
    
    func stopRecording() {
        guard let recorder = recorder else {
                    print("Recorder is not available")
                    return
                }
        recorder.stop()
        
    }
    
    @objc func fireTimer() {
        print("Timer fired!")
        updateMeters()
    }
    
    func TunerMicAcess() {
        //AVCaptureDevice method prompts user for microphone permission
        //User response is returned as a boolean value
        let captureSession = AVCaptureSession()
        let micAccess  = AVCaptureDevice.authorizationStatus(for: .audio)

        AVCaptureDevice.requestAccess(for: .audio) { [self] granted in

            if granted {
                createRecordingSession()
                tunerRecording()
            } else {
                print("Unable to access microphone.")
            }
        }
    }

    //Getting microphone access
    func microphoneAccess() {
        //AVCaptureDevice method prompts user for microphone permission
        //User response is returned as a boolean value
        let captureSession = AVCaptureSession()
        let micAccess  = AVCaptureDevice.authorizationStatus(for: .audio)

        AVCaptureDevice.requestAccess(for: .audio) { [self] granted in

            if granted {
                createRecordingSession()
                recording()
            } else {
                print("Unable to access microphone.")
            }
        }
    }

}
