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
            VStack(alignment: .leading, spacing: NCConstants.Margins.large.rawValue) {
                AddPhotoView(viewModel: viewModel, errorText: $viewModel.errorAddPhotosText)
                Text("Fields marked with * are mandatory to fill.")
                    .textStyle(.body03)
                    .foregroundStyle(Color(.text02!))
                titleSection()
                descriptionSection()
                categorySection()
                conditionSection()
                locationSection()
                priceSection()
            }
            .padding(.horizontal, NCConstants.Margins.large.rawValue)
            SwiftUIButton(
                text: "Upload item",
                trailingIcon: .init(image: Image(.sparkles), size: .huge),
                tapped: {
                    Task { await viewModel.uploadItemTapped() }
                    isTitleFocused = false
                    isDescriptionFocused = false
                    isPriceFocused = false
                }
            )
            .fixedSize()
            .padding(.top, NCConstants.Margins.large.rawValue)
        }
        .activityIndicator(show: $viewModel.isLoading)
    }
    
    @ViewBuilder
    private func titleSection() -> some View {
        VStack(alignment: .leading, spacing: NCConstants.Margins.small.rawValue) {
            Text("Title *")
                .textStyle(.subtitle02)
                .foregroundStyle(Color(.text01!))
            SwiftUITextInput(
                title: "",
                type: .primary,
                text: $viewModel.title,
                errorText: isTitleFocused && viewModel.title.isEmpty ? .constant(nil) : $viewModel.errorTitleText,
                isFocused: $isTitleFocused
            )
        }
    }
    
    @ViewBuilder
    private func descriptionSection() -> some View {
        VStack(alignment: .leading, spacing: NCConstants.Margins.small.rawValue) {
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
    }
    
    @ViewBuilder
    private func categorySection() -> some View {
        VStack(alignment: .leading, spacing: NCConstants.Margins.small.rawValue) {
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
    }
    
    @ViewBuilder
    private func conditionSection() -> some View {
        VStack(alignment: .leading, spacing: NCConstants.Margins.small.rawValue) {
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
    }
    
    @ViewBuilder
    private func locationSection() -> some View {
        VStack(alignment: .leading, spacing: NCConstants.Margins.small.rawValue) {
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
    }
    
    @ViewBuilder
    private func priceSection() -> some View {
        VStack(alignment: .leading, spacing: NCConstants.Margins.small.rawValue) {
            Text("Price (in €) *")
                .textStyle(.subtitle02)
                .foregroundStyle(Color(.text01!))
            PriceTextInput(
                title: "",
                amount: $viewModel.price,
                errorText: isPriceFocused ? .constant(nil) : $viewModel.errorPriceText,
                isFocused: $isPriceFocused
            )
            .keyboardType(.decimalPad)
        }
    }
}
