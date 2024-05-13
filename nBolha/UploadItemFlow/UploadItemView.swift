//
//  UploadItemView.swift
//  nBolha
//
//  Created by David Balažic on 9. 5. 24.
//

import SwiftUI
import NChainUI
import PhotosUI
import nBolhaUI

struct UploadItemView: View {
    @ObservedObject private var viewModel: UploadItemViewModel
    @FocusState private var isTitleFocused: Bool
    @FocusState private var isDescriptionFocused: Bool
    @FocusState private var isPriceFocused: Bool
    
    init(
        viewModel: UploadItemViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
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
                    .onChange(of: viewModel.pickerItems) {
                        viewModel.updatePickerItems()
                    }
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
                Text("Fields marked with * are mandatory to fill.")
                    .textStyle(.body03)
                    .foregroundStyle(Color(.text02!))
                VStack(alignment: .leading, spacing: 8) {
                    Text("Title *")
                        .textStyle(.subtitle02)
                        .foregroundStyle(Color(.text01!))
                    SwiftUITextInput(
                        title: "",
                        type: .primary,
                        text: $viewModel.title,
                        errorText: isTitleFocused ? .constant(nil) : $viewModel.errorTitleText,
                        isFocused: $isTitleFocused
                    )
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .textStyle(.subtitle02)
                        .foregroundStyle(Color(.text01!))
                    SwiftUITextInput(
                        title: "",
                        type: .description,
                        text: $viewModel.description,
                        errorText: $viewModel.errorDescriptionText,
                        isFocused: $isDescriptionFocused
                    )
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("Category *")
                        .textStyle(.subtitle02)
                        .foregroundStyle(Color(.text01!))
                    Menu {
                        Picker(selection: $viewModel.category, label: Text("")) {
                            ForEach(UploadItemViewModel.Category.allCases.filter { $0 != .unselected },  id: \.self) { option in
                                Text(option.rawValue)
                            }
                        }
                    } label: {
                        DropdownList(
                            text: viewModel.category.rawValue,
                            errorText: $viewModel.errorCategoryText
                        )
                    }
                    .onTapGesture {
                        isTitleFocused = false
                        isDescriptionFocused = false
                        isPriceFocused = false
                    }
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("Condition *")
                        .textStyle(.subtitle02)
                        .foregroundStyle(Color(.text01!))
                    Menu {
                        Picker(selection: $viewModel.condition, label: Text("")) {
                            ForEach(UploadItemViewModel.Condition.allCases.filter { $0 != .unselected },  id: \.self) { option in
                                Text(option.rawValue)
                            }
                        }
                    } label: {
                        DropdownList(
                            text: viewModel.condition.rawValue,
                            errorText: $viewModel.errorConditionText
                        )
                    }
                    .onTapGesture {
                        isTitleFocused = false
                        isDescriptionFocused = false
                        isPriceFocused = false
                    }
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("Location *")
                        .textStyle(.subtitle02)
                        .foregroundStyle(Color(.text01!))
                    Menu {
                        Picker(selection: $viewModel.location, label: Text("")) {
                            ForEach(UploadItemViewModel.Location.allCases.filter { $0 != .unselected },  id: \.self) { option in
                                Text(option.rawValue)
                            }
                        }
                    } label: {
                        DropdownList(
                            text: viewModel.location.rawValue,
                            errorText: $viewModel.errorLocationText
                        )
                    }
                    .onTapGesture {
                        isTitleFocused = false
                        isDescriptionFocused = false
                        isPriceFocused = false
                    }
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("Price (in €) *")
                        .textStyle(.subtitle02)
                        .foregroundStyle(Color(.text01!))
                    SwiftUITextInput(
                        title: "",
                        type: .primary,
                        text: $viewModel.price,
                        errorText: isPriceFocused ? .constant(nil) : $viewModel.errorPriceText,
                        isFocused: $isPriceFocused
                    )
                    .keyboardType(.decimalPad)
                }
            }
            SwiftUIButton(
                text: "Upload item",
                trailingIcon: .init(image: Image(.sparkles), size: .huge),
                tapped: {
                    viewModel.uploadItemTapped()
                    isTitleFocused = false
                    isDescriptionFocused = false
                    isPriceFocused = false
                }
            )
            .fixedSize()
            .padding(.top, 16)
        }
        .padding(.horizontal, 16)
    }
}
