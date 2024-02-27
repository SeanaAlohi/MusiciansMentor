//
//  dBMeter.swift
//  MusiciansFriend
//
//  Created by Melissa Gibney on 12/2/23.
//

import Foundation
import AVFoundation
import AudioKit
import UIKit

class dBMeter: ObservableObject {
    @Published var instantaneousDB = 0.0
    @Published var averageDB = 0.0
    
    func setInstantaneousDB(newDB : Double)
    {
        instantaneousDB = newDB;
    }
    
    func setAverageDB(newDB : Double)
    {
        averageDB = newDB;
    }
    
    func getInstantaneousDB() -> Double
    {
        return instantaneousDB
    }
    
    func getAverageDB() -> Double
    {
        return averageDB
    }
    
//    func updateDBMeterUI(averagePower : Float, peakPower : Float)
//    {
//        //Update UI Labels and Meter
//        setInstantaneousDB(newDB : Double(peakPower))
//        setAverageDB(newDB: Double(averagePower))
//        if(peakPower > 120)
//        {
//            showNoiseLevelAlert()
//        }
//    }
    
//    func showNoiseLevelAlert()
//    {
//        //Create the Alert
//        let noiseAlert = UIAlertController(title: "Dangerous Noise Level", message: "You are currently experiencing dangerous noise levels.  You may want to use ear plugs to avoid hearing damage.", preferredStyle: .alert)
//        noiseAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
//        //Show the alert
//        //noiseAlert.show(getCurrentViewController(), sender: nil)
//    }
    
    /*func getCurrentViewController() -> UIViewController
    {
        return dBMeterView()
    }*/
}
