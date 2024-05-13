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
    @State private var title = ""
    @FocusState private var isTitleFocused: Bool
    @State private var titleError: String?
    enum Category: String, CaseIterable {
        case unselected = "Select..."
        case home = "Home"
        case construction = "Construction"
        case automative = "Automative"
        case sport = "Sport"
        case audiovisual = "Audiovisual"
        case literature = "Literature"
        case hobbies = "Hobbies"
        case apparel = "Apparel"
        case services = "Services"
    }
    @State private var category: Category = .unselected
    enum Condition: String, CaseIterable {
        case unselected = "Select..."
        case withTags = "New with tags"
        case withoutTags = "New without tags"
        case veryGood = "Very good"
        case satisfactory = "Satisfactory"
    }
    @State private var condition: Condition = .unselected
    enum Location: String, CaseIterable {
        case unselected = "Select..."
        case maribor = "Maribor"
        case ljubljana = "Ljubljana"
    }
    @State private var location: Location = .unselected
    
    init(
        viewModel: UploadItemViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                VStack(spacing: 16) {
                    SwiftUIButton(
                        text: "Add photos",
                        leadingIcon: .init(image: Image(.plus), size: .large),
                        style: .outlined,
                        size: .small
                    ) {
                       //TODO: implement
                        print("tapped")
                    }
                    .fixedSize()
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
                        text: $title,
                        errorText: $titleError,
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
                        text: $title,
                        errorText: $titleError,
                        isFocused: $isTitleFocused
                    )
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("Category *")
                        .textStyle(.subtitle02)
                        .foregroundStyle(Color(.text01!))
                    Menu {
                        Picker(selection: $category, label: Text("")) {
                            ForEach(Category.allCases.filter { $0 != .unselected },  id: \.self) { option in
                                Text(option.rawValue)
                            }
                        }
                    } label: {
                        DropdownList(
                            text: category.rawValue,
                            errorText: $titleError
                        )
                    }
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("Condition *")
                        .textStyle(.subtitle02)
                        .foregroundStyle(Color(.text01!))
                    Menu {
                        Picker(selection: $condition, label: Text("")) {
                            ForEach(Condition.allCases.filter { $0 != .unselected },  id: \.self) { option in
                                Text(option.rawValue)
                            }
                        }
                    } label: {
                        DropdownList(
                            text: condition.rawValue,
                            errorText: $titleError
                        )
                    }
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("Location *")
                        .textStyle(.subtitle02)
                        .foregroundStyle(Color(.text01!))
                    Menu {
                        Picker(selection: $location, label: Text("")) {
                            ForEach(Location.allCases.filter { $0 != .unselected },  id: \.self) { option in
                                Text(option.rawValue)
                            }
                        }
                    } label: {
                        DropdownList(
                            text: location.rawValue,
                            errorText: $titleError
                        )
                    }
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("Price (in €) *")
                        .textStyle(.subtitle02)
                        .foregroundStyle(Color(.text01!))
                    SwiftUITextInput(
                        title: "",
                        type: .primary,
                        text: $title,
                        errorText: $titleError,
                        isFocused: $isTitleFocused
                    )
                }
            }
            SwiftUIButton(
                text: "Upload item",
                trailingIcon: .init(image: Image(.sparkles), size: .huge)
            ) {
                //TODO: implement
            }
            .fixedSize()
            .padding(.top, 16)
        }
        .padding(.horizontal, 16)
    }
}
