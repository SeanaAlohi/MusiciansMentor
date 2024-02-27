//
//  HearingInfoView.swift
//  Musicians_Friend_Final
//
//  Created by Gibney, Melissa on 12/19/23.
//

import SwiftUI

struct HearingInfoView: View {
    var body: some View {
        NavigationView
        {
            List{
                NavigationLink("About Hearing Loss", destination: HearingLossInfoView())
                NavigationLink("Hearing Protection Info", destination: HearingProtectionInfoView())
            }
        }
    }
}

#Preview {
    HearingInfoView()
}
