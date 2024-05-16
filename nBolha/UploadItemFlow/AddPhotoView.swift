//
//  AddPhotoView.swift
//  nBolha
//
//  Created by David Balažic on 13. 5. 24.
//

import SwiftUI
import PhotosUI
import NChainUI

struct AddPhotoView: View {
    @ObservedObject private var viewModel: UploadItemViewModel
    @Binding private var errorText: String?
    
    private var isError: Bool {
        errorText != nil
    }
    
    public init(
        viewModel: UploadItemViewModel,
        errorText: Binding<String?>
    ) {
        self.viewModel = viewModel
        self._errorText = errorText
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                if !viewModel.selectedImages.isEmpty {
                    ImageView(viewModel: viewModel)
                }
                PhotosPicker(selection: $viewModel.pickerItems, maxSelectionCount: 5, matching: .images) {
                    HStack(spacing: 8) {
                        Image(.plus)
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color(.brandPrimary!))
                            .frame(
                                maxWidth: 18,
                                maxHeight: 18
                            )
                        Text("Add photos")
                            .textStyle(.subtitle03)
                            .foregroundStyle(Color(.brandPrimary!))
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(.brandPrimary!), lineWidth: 1)
                    )
                }
                .padding(.bottom, 16)
                .padding(.top, viewModel.selectedImages.isEmpty ? 37 : 0)
                Text("Add up to 5 photos (.jpg, .gif or .png, max. 2MB)")
                    .textStyle(.caption02)
                    .foregroundStyle(Color(.text02!))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 56)
                    .padding(.bottom, viewModel.selectedImages.isEmpty ? 37 : 24)
            }
            .frame(maxWidth: .infinity)
            .background(Color(.background05!))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [3]))
                    .foregroundColor(Color(.outline01!))
            )
            if isError {
                Rectangle()
                    .foregroundColor(Color(.errorDefault!))
                    .frame(height: 4)
                    .cornerRadius(32, corners: [.bottomLeft, .bottomRight])
                    .offset(y: -9)
                    .opacity(isError ? 1 : 0)
                    .animation(.quickSmooth, value: isError)
                
                Text(errorText ?? "")
                    .font(Font(UIFont.caption01))
                    .foregroundColor(Color(.errorDefault!))
                    .background(Color.clear)
                    .offset(y: -5)
                    .opacity(isError ? 1 : 0)
                    .padding(.vertical, isError ? 3 : -5)
                    .animation(.quickSmooth, value: isError)
                    .padding(.leading, 12)
            }
        }
        .padding(2)
    }
}
