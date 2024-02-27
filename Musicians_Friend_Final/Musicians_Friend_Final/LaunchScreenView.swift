//
//  LaunchScreenView.swift
//  Project3
//
//  Created by Seana Marie Lanias on 12/9/22.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @AppStorage("colorScheme") var colorScheme = 0
    
    var body: some View {
        
        if isActive {
            ContentView()
        }
        else{
            VStack{
                VStack{
                    Image("launch")
                        .resizable()
                        .scaledToFit()
                        .background(.white)
                        .frame(maxHeight: 300)
                        .cornerRadius(12)
                        .shadow(radius: 8, x: 5, y: 5)
                        .padding()
                    Text("Music Mentor <3")
                        .bold()
                        .font(.system(size: 24))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.5)){
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.isActive = true
                }
            }
            .preferredColorScheme(colorScheme == 1 ? .light: colorScheme == 2 ? .dark : nil)
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
