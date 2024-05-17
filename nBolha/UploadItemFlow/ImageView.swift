//
//  ImageItem.swift
//  nBolha
//
//  Created by David Balažic on 10. 5. 24.
//

import SwiftUI
import PhotosUI
import NChainUI

struct ImageView: View {
    @ObservedObject private var viewModel: UploadItemViewModel
    
    init(
        viewModel: UploadItemViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(viewModel.selectedImages.indices, id: \.self) { index in
                    VStack(spacing: 8) {
                        ImageItem(image: $viewModel.selectedImages[index]) {
                            viewModel.removeImage(at: index)
                        }
                        HStack(spacing: 12) {
                            Spacer()
                            Button(action: {
                                viewModel.moveImageUp(at: index)
                            }) {
                                Image(.arrowLeft)
                            }
                            Button(action: {
                                viewModel.moveImageDown(at: index)
                            }) {
                                Image(.arrowRight)
                            }
                            Button(action: {
                                viewModel.rotateImage(at: index)
                            }) {
                                Image(.rotate)
                            }
                            Spacer()
                        }
                    }
                }
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 16)
        }
    }
}
