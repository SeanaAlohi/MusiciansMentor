//
//  Search.swift
//  MusicMentor
//
//  Created by Lanias, Seana Marie on 12/14/23.
//

import Foundation
import SwiftUI
import WebKit


struct SheetViewRep: UIViewRepresentable {
    
    typealias UIViewType = WKWebView
    enum State: String {
        case standby, inProgress, error, done
    }
    
    var urlString: String
    @Binding var state: State
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: SheetViewRep
        
        init(_ parent: SheetViewRep) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.state = .inProgress
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.state = .error
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.state = .done
        }
    }
    
    func makeCoordinator() -> Coordinator { Coordinator(self) }
    
    func makeUIView(context: Context) -> UIViewType {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        switch state {
        case .standby:
            if let url = URL(string: urlString) {
                uiView.load(URLRequest(url: url))
            }
        default: break
        }
    }
    
   
}
