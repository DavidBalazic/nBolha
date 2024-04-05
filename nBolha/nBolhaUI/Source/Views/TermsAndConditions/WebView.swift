//
//  TermsView.swift
//  nBolha
//
//  Created by David Balažic on 2. 4. 24.
//

import SwiftUI

public struct WebView: View {
    @State private var isNavigationBarHidden = true
    private var url: URL?

    public init(
        url: URL
    ) {
        self.url = url
    }

    public var body: some View {
        if let url = url {
            WebViewRepresentable(url: url)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(isNavigationBarHidden)
                .onAppear {
                    isNavigationBarHidden = false
                }
                .onDisappear {
                    isNavigationBarHidden = true
                }
        }
        else {
            Text("URL not available")
        }
    }
}



//#Preview {
//    TermsView()
//}
