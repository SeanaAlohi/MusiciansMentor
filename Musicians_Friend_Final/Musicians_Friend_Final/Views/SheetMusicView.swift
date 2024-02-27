//
//  SheetMusicView.swift
//  Musicians_Friend_Final
//
//  Created by Nazario, Mariela on 12/19/23.
//

import SwiftUI

struct SheetMusicView: View {
    
    @State private var urlString = "https://royaltymusic.net/music/latest-sheet-music/"
    @State var state = SheetViewRep.State.standby
    @FocusState var focus: Bool
    
    var body: some View {
        VStack {
            SearchBarView(goString: $urlString, focus: _focus, title: "Search") {
                state = SheetViewRep.State.standby
            }
                SheetViewRep(urlString: urlString, state: $state)
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
    SheetMusicView()
}
