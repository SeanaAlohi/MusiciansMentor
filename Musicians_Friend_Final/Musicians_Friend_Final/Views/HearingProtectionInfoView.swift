//
//  HearingProtectionInfoView.swift
//  Musicians_Friend_Final
//
//  Created by Gibney, Melissa on 12/19/23.
//

import SwiftUI

struct HearingProtectionInfoView: View {
    var body: some View {
        VStack
        {
            Text("Hearing Protection")
            Text("")
            Text("  Hearing Protection is one of the best ways to prevent hearing loss.  Wearing earplugs while at a loud concert or just going abut your daily life can decrease or even halt hearing loss.  Brands such as Vic Firth carry good earplugs, but getting custom-fitted for a pair is even more effective.")
        }.frame(maxWidth: 400)
    }
}

#Preview {
    HearingProtectionInfoView()
}
