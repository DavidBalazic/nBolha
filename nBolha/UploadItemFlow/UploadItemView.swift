//
//  UploadItemView.swift
//  nBolha
//
//  Created by David Balažic on 9. 5. 24.
//

import SwiftUI

struct UploadItemView: View {
    @ObservedObject private var viewModel: UploadItemViewModel
    
    init(
        viewModel: UploadItemViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
