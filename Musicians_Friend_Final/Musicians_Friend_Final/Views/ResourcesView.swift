//
//  ResourcesView.swift
//  Metronome
//
//  Created by Majewski, Connor on 11/4/23.
//

import Foundation
import SwiftUI

struct ResourcesView: View {
    
    var body: some View {
        NavigationView
        {
            List{
                NavigationLink("Sheet Music", destination: SheetMusicView())
                NavigationLink("Tutorials", destination: TutorialsView())
                NavigationLink("Hearing Resources", destination: HearingInfoView())
            }
        }
    }
}

struct ResourcesView_Previews: PreviewProvider {
    static var previews: some View {
        ResourcesView()
    }
}
