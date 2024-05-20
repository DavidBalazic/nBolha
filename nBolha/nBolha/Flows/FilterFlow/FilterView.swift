//
//  FilterView.swift
//  nBolha
//
//  Created by David Balažic on 23. 4. 24.
//

import SwiftUI
import nBolhaUI
import NChainUI

struct FilterView: View {
    @ObservedObject private var viewModel: FilterViewModel
    @Binding var isFilterTapped: Bool
    let applyFilters: ([Condition], SortBy) -> Void
    
    init(
        viewModel: FilterViewModel,
         isFilterTapped: Binding<Bool>,
         applyFilters: @escaping ([Condition], SortBy) -> Void
    ) {
        self.viewModel = viewModel
        self._isFilterTapped = isFilterTapped
        self.applyFilters = applyFilters
    }

    var body: some View {
        HStack {
            Button(action: {
                viewModel.resetFilters()
            }) {
                Text("Reset")
                    .textStyle(.body02)
                    .foregroundStyle(Color(UIColor.outline03!))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Text("Filter")
                .textStyle(.subtitle01)
                .foregroundStyle(Color(UIColor.brandPrimary!))
                .frame(maxWidth: .infinity, alignment: .center)
            Button(action: {
                isFilterTapped.toggle()
            }) {
                Image(.x)
                    .foregroundColor(Color(.icons03!))
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(NCConstants.Margins.extraLarge.rawValue)
        ScrollView(showsIndicators: false) {
            VStack(spacing: NCConstants.Margins.extraLarge.rawValue) {
                VStack(alignment: .leading, spacing: NCConstants.Margins.medium.rawValue) {
                    HStack {
                        Image(.sortByIcon)
                        Text("Sort by")
                            .textStyle(.subtitle02)
                            .foregroundStyle(Color(UIColor.brandPrimary!))
                        Spacer()
                    }
                    RadioButton(tag: .newest, selection: $viewModel.selectedRadioButton, label: "Newest to oldest")
                    RadioButton(tag: .oldest, selection: $viewModel.selectedRadioButton, label: "Oldest to newest")
                    RadioButton(tag: .lowToHigh, selection: $viewModel.selectedRadioButton, label: "Price: low to high")
                    RadioButton(tag: .highToLow, selection: $viewModel.selectedRadioButton, label: "Price: high to low")
                }
                VStack(alignment: .leading, spacing: NCConstants.Margins.medium.rawValue) {
                    HStack {
                        Image(.conditionIcon)
                        Text("Condition")
                            .textStyle(.subtitle02)
                            .foregroundStyle(Color(UIColor.brandPrimary!))
                        Spacer()
                    }
                    SwiftUICheckBox(
                        title: "New with tags",
                        text: "A brand-new, unused item with tags or original packaging.",
                        checked: Binding(
                            get: {
                                viewModel.selectedCheckBoxes.contains(.withTags)
                            },
                            set: { isChecked in
                                viewModel.toggleCondition(.withTags)
                            }
                        ),
                        style: SwiftUICheckBox.Style(
                            font: .subtitle02,
                            textColor: Color(.text02!),
                            iconColor: Color(.text02!),
                            disabledIconColor: Color(.brandSecondary!)
                        )
                    )
                    SwiftUICheckBox(
                        title: "New without tags",
                        text: "A brand-new, unused item without tags or original packaging.",
                        checked: Binding(
                            get: {
                                viewModel.selectedCheckBoxes.contains(.withoutTags)
                            },
                            set: { isChecked in
                                viewModel.toggleCondition(.withoutTags)
                            }
                        ),
                        style: SwiftUICheckBox.Style(
                            font: .subtitle02,
                            textColor: Color(.text02!),
                            iconColor: Color(.text02!),
                            disabledIconColor: Color(.brandSecondary!)
                        )
                    )
                    SwiftUICheckBox(
                        title: "Very good",
                        text: "A lightly used item that may have slight imperfections.",
                        checked: Binding(
                            get: {
                                viewModel.selectedCheckBoxes.contains(.veryGood)
                            },
                            set: { isChecked in
                                viewModel.toggleCondition(.veryGood)
                            }
                        ),
                        style: SwiftUICheckBox.Style(
                            font: .subtitle02,
                            textColor: Color(.text02!),
                            iconColor: Color(.text02!),
                            disabledIconColor: Color(.brandSecondary!)
                        )
                    )
                    SwiftUICheckBox(
                        title: "Satisfactory",
                        text: "A frequently used item with imperfections and signs of wear.",
                        checked: Binding(
                            get: {
                                viewModel.selectedCheckBoxes.contains(.satisfactory)
                            },
                            set: { isChecked in
                                viewModel.toggleCondition(.satisfactory)
                            }
                        ),
                        style: SwiftUICheckBox.Style(
                            font: .subtitle02,
                            textColor: Color(.text02!),
                            iconColor: Color(.text02!),
                            disabledIconColor: Color(.brandSecondary!)
                        )
                    )
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, NCConstants.Margins.extraLarge.rawValue)
            .padding(.bottom, NCConstants.Margins.extraLarge.rawValue)
        }
        SwiftUIButton(text: "View results") {
            applyFilters(viewModel.selectedCheckBoxes, viewModel.selectedRadioButton)
            isFilterTapped.toggle()
        }
        .padding(.horizontal, 20)
    }
}
