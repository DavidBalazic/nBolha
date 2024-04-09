//
//  WebView.swift
//  nBolhaUI
//
//  Created by David Balažic on 3. 4. 24.
//

import SwiftUI
import WebKit

struct WebViewRepresentable: UIViewRepresentable {
    let url: URL

    init(
        url: URL
    ) {
        self.url = url
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
           
    }
}
