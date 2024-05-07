//
//  CategoriesDetailView.swift
//  nBolha
//
//  Created by David Balažic on 11. 4. 24.
//

import SwiftUI
import nBolhaUI
import NChainUI

struct CategoriesDetailView: View {
    @ObservedObject private var viewModel: CategoriesViewModel
    @ObservedObject private var filterViewModel: FilterViewModel
    @State private var search = ""
    @State private var isFilterTapped = false
    @State private var showChipView = false
    
    init(
        viewModel: CategoriesViewModel,
        filterViewModel: FilterViewModel
    ) {
        self.viewModel = viewModel
        self.filterViewModel = filterViewModel
    }
    
    var body: some View {
        SearchBar(text: $search)
        VStack(spacing: NCConstants.Margins.large.rawValue) {
            HStack {
                Text("Home")
                    .textStyle(.subtitle02)
                    .foregroundStyle(Color(.brandTertiary!))
                Spacer()
                Button(action: {
                    isFilterTapped.toggle()
                }) {
                    ZStack(alignment: .topTrailing) {
                        Image(.filter)
                            .frame(width: 20, height: 20)
                        if !filterViewModel.selectedCheckBoxes.isEmpty || filterViewModel.selectedRadioButton != .newest {
                            Text("\(filterViewModel.selectedCheckBoxes.count + (filterViewModel.selectedRadioButton != .newest ? 1 : 0))")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(Color(.background01!))
                                .frame(width: 12, height: 12)
                                .background(Color(.brandPrimary!))
                                .clipShape(Circle())
                                .offset(x: 4, y: -4)
                        }
                    }
                }
            }
            if !filterViewModel.selectedCheckBoxes.isEmpty || filterViewModel.selectedRadioButton != .newest{
                let chips: [String] = {
                    var chips = filterViewModel.selectedCheckBoxes.map { $0.rawValue }
                    if filterViewModel.selectedRadioButton != .newest {
                        chips.append(filterViewModel.selectedRadioButton.rawValue)
                    }
                    return chips
                }()
                WrappingHStack(horizontalSpacing: NCConstants.Margins.small.rawValue, verticalSpacing: NCConstants.Margins.medium.rawValue) {
                    ForEach(chips, id: \.self) { value in
                        SwifUIChipView(
                            title: value,
                            size: .medium,
                            style: .init(disabledBackgroundColor: Color(.background05!), disabledBorderColor: .clear, disabledTintColor: Color(.text01!)),
                            state: .disabled,
                            trailingIcon: Image(.x),
                            trailingIconTapped: {
                                //TODO: implement
                                print("Tapped")
                            }
                        )
                    }
                }
            }
        }
        .padding(.horizontal, NCConstants.Margins.large.rawValue)
        .padding(.bottom, NCConstants.Margins.extraLarge.rawValue)
        ScrollView(showsIndicators: false) {
            if viewModel.advertisements.isEmpty {
                EmptyCategoriesView(category: "Home")
            } else {
                let pairs = viewModel.advertisements.chunked(into: 2)
                ForEach(pairs, id: \.self) { pair in
                    HStack(alignment: .top, spacing: NCConstants.Margins.large.rawValue) {
                        ForEach(pair, id: \.advertisementId) { advertisement in
                            AdvertisementItemsView(
                                advertisement: advertisement,
                                itemTapped: {
                                    viewModel.advertisementItemTapped(selectedAdvertisement: advertisement)
                                }, 
                                likeButtonTapped: {
                                    viewModel.likeAdvertisementTapped(advertisementId: advertisement.advertisementId ?? 0)
                                },
                                dislikeButtonTapped: {
                                    viewModel.dislikeAdvertisementTapped(advertisementId: advertisement.advertisementId ?? 0)
                                }
                            )
                        }
                    }
                }
            }
        }
        .padding(.horizontal, NCConstants.Margins.large.rawValue)
        .sheet(isPresented: $isFilterTapped) {
            FilterView(
                viewModel: filterViewModel,
                isFilterTapped: $isFilterTapped,
                selectedRadioButton: filterViewModel.selectedRadioButton,
                selectedCheckBoxes: filterViewModel.selectedCheckBoxes
            )
            .presentationDetents([.fraction(0.95)])
            .presentationDragIndicator(.hidden)
        }
    }
}
