//
//  TestView.swift
//  nBolha
//
//  Created by Adel Burekovic on 20. 03. 24.
//

import SwiftUI
import Combine
import NChainUI

struct TestView: View {
    @ObservedObject private var viewModel: TestViewModel
    @FocusState private var isFirstFieldFocused: Bool

    init(viewModel: TestViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: NCConstants.Margins.medium.rawValue) {
            SwiftUITextInput(
                title: "Name",
                type: .primary,
                text: $viewModel.nameText,
                errorText: $viewModel.errorText,
                isFocused: $isFirstFieldFocused
            )
            
            SwiftUIButton(
                text: "Click me",
                tapped: {
                    print("hello")
                }
            )
        }
        .padding(
            .horizontal,
            NCConstants.Margins.huge.rawValue
        )
        .onAppear {
            print("test")
        }
    }
}

//#Preview {
//    TestView(
//        viewModel: TestViewModel(navigationDelegate: nil)
//    )
//}
