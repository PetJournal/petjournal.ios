//
//  WebView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 26/05/23.
//

import SwiftUI
import WebKit

struct WebView: View {
    
    var body: some View {
        ZStack {
            WebViewContainer(url: URL(string: "https://www.google.com")!)
        }
    }
}

struct WebViewContainer: UIViewRepresentable {
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
