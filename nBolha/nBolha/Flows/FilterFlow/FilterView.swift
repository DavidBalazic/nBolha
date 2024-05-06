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
    @State private var isCheckedWithTags = false
    @State private var isCheckedWithoutTags = false
    @State private var isCheckedGood = false
    @State private var isCheckedSatisfactory = false
    @State var selectedOption: SortBy? = nil
    enum SortBy {
        case newest
        case oldest
        case lowToHigh
        case highToLow
    }
    
    var body: some View {
        HStack {
            Button(action: {
              //TODO: implement
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
              //TODO: implement
            }) {
                Image(uiImage: .icnClose ?? UIImage())
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
                    RadioButton(tag: .newest, selection: $selectedOption, label: "Newest to oldest")
                    RadioButton(tag: .oldest, selection: $selectedOption, label: "Oldest to newest")
                    RadioButton(tag: .lowToHigh, selection: $selectedOption, label: "Price: low to high")
                    RadioButton(tag: .highToLow, selection: $selectedOption, label: "Price: high to low")
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
                        text: "A brand-new, unused item with tags or original packaging.", checked: $isCheckedWithTags,
                        style: SwiftUICheckBox.Style(
                            font: .subtitle02,
                            textColor: Color(.text02!),
                            iconColor: Color(.text02!),
                            disabledIconColor: Color(.brandSecondary!)
                        )
                    )
                    SwiftUICheckBox(
                        title: "New without tags",
                        text: "A brand-new, unused item without tags or original packaging.", checked: $isCheckedWithoutTags,
                        style: SwiftUICheckBox.Style(
                            font: .subtitle02,
                            textColor: Color(.text02!),
                            iconColor: Color(.text02!),
                            disabledIconColor: Color(.brandSecondary!)
                        )
                    )
                    SwiftUICheckBox(
                        title: "Very good",
                        text: "A lightly used item that may have slight imperfections.", checked: $isCheckedGood,
                        style: SwiftUICheckBox.Style(
                            font: .subtitle02,
                            textColor: Color(.text02!),
                            iconColor: Color(.text02!),
                            disabledIconColor: Color(.brandSecondary!)
                        )
                    )
                    SwiftUICheckBox(
                        title: "Satisfactory",
                        text: "A frequently used item with imperfections and signs of wear.", checked: $isCheckedSatisfactory,
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
            //TODO: implement
        }
        .padding(.horizontal, 20)
    }
}
