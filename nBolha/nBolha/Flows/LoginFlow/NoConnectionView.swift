//
//  NoConnectionView.swift
//  nBolha
//
//  Created by David Balažic on 25. 3. 24.
//

import SwiftUI
import NChainUI

struct NoConnectionView: View {
    @ObservedObject private var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        VStack(spacing: NCConstants.Margins.extraLarge.rawValue) {
            Image("Illustrations2")
            VStack(spacing: NCConstants.Margins.medium.rawValue) {
                Text("No connection")
                    .font(Font(UIFont.title05))
                    .foregroundStyle(Color(UIColor.text01!))
                Text("No internet connection found. Check your connection or try again.")
                    .font(Font(UIFont.body03))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color(UIColor.text02!))
            }
            .padding(.bottom, NCConstants.Margins.extraLarge.rawValue)
            SwiftUIButton(
                text: "Try again",
                tapped: {
                    //Retry network connection
                }
            )
        }
        .padding(.horizontal, NCConstants.Margins.large.rawValue)
    }
}

func tryAgain() {
    
}
 
//#Preview {
//    NoConnectionView()
//}
