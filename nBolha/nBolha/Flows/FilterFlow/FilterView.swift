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
    @State private var isCheckedWithTags = false
    @State private var isCheckedWithoutTags = false
    @State private var isCheckedGood = false
    @State private var isCheckedSatisfactory = false
    @State var selectedRadioButton: SortBy
    @State private var selectedCheckBoxes: [Condition]
    
    enum SortBy: String {
        case newest = "Newest to oldest"
        case oldest = "Oldest to newest"
        case lowToHigh = "Price: low to high"
        case highToLow = "Price: high to low"
    }
    
    enum Condition: String {
        case withTags = "New with tags"
        case withoutTags = "New without tags"
        case veryGood = "Very good"
        case satisfactory = "Satisfactory"
    }
    
    init(
        viewModel: FilterViewModel,
        isFilterTapped: Binding<Bool>,
        selectedRadioButton: SortBy,
        selectedCheckBoxes: [Condition]
    ) {
        self.viewModel = viewModel
        self._isFilterTapped = isFilterTapped
        self.selectedRadioButton = selectedRadioButton
        self.selectedCheckBoxes = selectedCheckBoxes
    }
    
    var body: some View {
        HStack {
            Button(action: {
                selectedRadioButton = .newest
                selectedCheckBoxes = []
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
                    RadioButton(tag: .newest, selection: $selectedRadioButton, label: "Newest to oldest")
                    RadioButton(tag: .oldest, selection: $selectedRadioButton, label: "Oldest to newest")
                    RadioButton(tag: .lowToHigh, selection: $selectedRadioButton, label: "Price: low to high")
                    RadioButton(tag: .highToLow, selection: $selectedRadioButton, label: "Price: high to low")
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
                        title: Condition.withTags.rawValue,
                        text: "A brand-new, unused item with tags or original packaging.",
                        checked: Binding(
                            get: {
                                selectedCheckBoxes.contains(.withTags)
                            },
                            set: { isChecked in
                                if isChecked {
                                    selectedCheckBoxes.append(.withTags)
                                } else {
                                    selectedCheckBoxes.removeAll { $0 == .withTags }
                                }
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
                        title: Condition.withoutTags.rawValue,
                        text: "A brand-new, unused item without tags or original packaging.",
                        checked: Binding(
                            get: {
                                selectedCheckBoxes.contains(.withoutTags)
                            },
                            set: { isChecked in
                                if isChecked {
                                    selectedCheckBoxes.append(.withoutTags)
                                } else {
                                    selectedCheckBoxes.removeAll { $0 == .withoutTags }
                                }
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
                        title: Condition.veryGood.rawValue,
                        text: "A lightly used item that may have slight imperfections.",
                        checked: Binding(
                            get: {
                                selectedCheckBoxes.contains(.veryGood)
                            },
                            set: { isChecked in
                                if isChecked {
                                    selectedCheckBoxes.append(.veryGood)
                                } else {
                                    selectedCheckBoxes.removeAll { $0 == .veryGood }
                                }
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
                        title: Condition.satisfactory.rawValue,
                        text: "A frequently used item with imperfections and signs of wear.", 
                        checked: Binding(
                            get: {
                                selectedCheckBoxes.contains(.satisfactory)
                            },
                            set: { isChecked in
                                if isChecked {
                                    selectedCheckBoxes.append(.satisfactory)
                                } else {
                                    selectedCheckBoxes.removeAll { $0 == .satisfactory }
                                }
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
            viewModel.setSelectedOptions(selectedCheckBoxes: selectedCheckBoxes, selectedRadioButton: selectedRadioButton)
            isFilterTapped.toggle()
        }
        .padding(.horizontal, 20)
    }
}
