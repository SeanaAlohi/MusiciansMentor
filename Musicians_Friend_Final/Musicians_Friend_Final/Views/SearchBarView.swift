//
//  SearchBarView.swift
//  MusicMentor
//
//  Created by Lanias, Seana Marie on 12/14/23.
//

import Foundation
import SwiftUI


struct SearchBarView: View {
    
    @Binding var goString: String
    @FocusState var focus: Bool
    var title: String

    var action: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            Text(title)
                .font(.body)
                .fontWeight(.heavy)
            TextField(title, text: $goString)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .textFieldStyle(.roundedBorder)
                .focused($focus)
                .onSubmit {
                    if let doIt = action { doIt() }
                }
            Button {
                if let doIt = action { doIt() }
            } label: {
                Label("", systemImage: "arrow.clockwise")
            }
            .clipShape(Rectangle())
            .disabled(goString.isEmpty)
        }
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(goString: .constant(""), title: "Search")
    }
}
