//
//  TestView.swift
//  nBolha
//
//  Created by Adel Burekovic on 20. 03. 24.
//

import SwiftUI
import Combine
import nBolhaUI

struct TestView: View {
    @ObservedObject private var viewModel: TestViewModel

    init(viewModel: TestViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Text("TEST VIEW")
        }
        .background(Color.red)
    }
}

#Preview {
    TestView(
        viewModel: TestViewModel(navigationDelegate: nil)
    )
}
