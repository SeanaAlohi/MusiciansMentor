//
//  HearingLossInfoView.swift
//  Musicians_Friend_Final
//
//  Created by Gibney, Melissa on 12/19/23.
//

import SwiftUI

struct HearingLossInfoView: View {
    var body: some View {
        VStack
        {
            Text("Hearing Loss")
            Text("")
            ScrollView
            {
                Text("  Hearing loss occurs when one is exposed to loud noises for extended periods of time.  The amount of damage done corresponds to the loudness of the noise and the length of time of the exposure.  Organizations such as OSHA have safety regulations and charts sowing what levels of loudness are safe and the length of time one may be exposed before permanent damage occurs.")
                Text("")
                Text("  A person's ear is composed of the ear canal, the ear drum, the cochlea, and other various components.  Hearing loss occurs when the stereocilia (tiny hairs) inside of the cochlea are damaged fromoverexposure to loud noise.  These hairs cannot grow back, leading to permanent hearing damage that may only be somewhat remedied by hearing aids or surgery.  Extremely loud noises can rupture the ear drum and also cause hearing loss.")
                Text("")
                Text("  Temporary hearing loss can occr for many reasons, one of which is a buildup of wax in the ear.  If this happens, you should not try to clean your ear using Q-Tips as this only pushes the wax in and increases buildup.  Instead, consult your doctor abut removing the wax properly.")
            }
        }.frame(maxWidth: 400)
    }
}

#Preview {
    HearingLossInfoView()
}
