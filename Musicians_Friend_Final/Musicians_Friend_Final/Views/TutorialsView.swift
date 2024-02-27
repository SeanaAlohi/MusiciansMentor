//
//  TutorialsView.swift
//  Musicians_Friend_Final
//
//  Created by Gibney, Melissa on 12/19/23.
//

import SwiftUI

struct TutorialsView: View {
    
    @State private var urlString = "https://www.musictheory.net/lessons"
    @State var state = TutorialsViewRep.State.standby
    @FocusState var focus: Bool
    
    var body: some View {
        VStack {
            SearchBarView(goString: $urlString, focus: _focus, title: "Search") {
                state = TutorialsViewRep.State.standby
            }
                TutorialsViewRep(urlString: urlString, state: $state)
                    .opacity(state == .done ? 1 : 0)
                
                if state == .inProgress {
                    ProgressView()
                }
            }
        .onTapGesture { focus = false }
        
        Spacer()
    }
}

#Preview {
    TutorialsView()
}
