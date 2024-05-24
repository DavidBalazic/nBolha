//
//  CategoriesDetailView.swift
//  nBolha
//
//  Created by David Balažic on 11. 4. 24.
//

import SwiftUI
import nBolhaUI
import NChainUI

struct CategoryDetailView: View {
    @ObservedObject private var viewModel: CategoryDetailViewModel
    @State private var isFilterTapped = false
    @State private var showChipView = false
    
    init(
        viewModel: CategoryDetailViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        SearchBar(text: $viewModel.search, isEditing: $viewModel.isEditing)
            .submitLabel(.search)
            .onSubmit {
                viewModel.applySearchTapped()
            }
        VStack(spacing: NCConstants.Margins.large.rawValue) {
            HStack {
                Text(viewModel.category ?? "All results")
                    .textStyle(.subtitle02)
                    .foregroundStyle(Color(.brandTertiary!))
                Spacer()
                if !viewModel.advertisements.isEmpty || !viewModel.conditions.isEmpty {
                    Button(action: {
                        isFilterTapped.toggle()
                    }) {
                        ZStack(alignment: .topTrailing) {
                            Image(.filter)
                                .frame(width: 20, height: 20)
                            if !viewModel.conditions.isEmpty || viewModel.order != .newest {
                                Text("\(viewModel.conditions.count + (viewModel.order != .newest ? 1 : 0))")
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
            }
            if !viewModel.conditions.isEmpty || viewModel.order != .newest {
                let chips: [String] = {
                    var chips = viewModel.conditions.map { $0.rawValue }
                    if viewModel.order != .newest {
                        chips.append(viewModel.order.rawValue)
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
                                viewModel.removeFilterTapped(value: value)
                            }
                        )
                    }
                }
            }
        }
        .padding(.horizontal, NCConstants.Margins.large.rawValue)
        ScrollView(showsIndicators: false) {
            VStack {
                if viewModel.advertisements.isEmpty {
                    EmptyCategoriesView(
                        browseCategoriesTapped: {
                            viewModel.browseCategoriesTapped()
                        }
                    )
                } else {
                    let pairs = viewModel.advertisements.chunked(into: 2)
                    ForEach(pairs, id: \.self) { pair in
                        HStack(alignment: .top, spacing: NCConstants.Margins.large.rawValue) {
                            ForEach(pair, id: \.advertisementId) { advertisement in
                                AdvertisementItemsView(
                                    advertisement: advertisement,
                                    itemTapped: {
                                        viewModel.advertisementItemTapped(advertisementId: advertisement.advertisementId ?? 0)
                                    },
                                    likeButtonTapped: {
                                        viewModel.likeAdvertisementTapped(advertisementId: advertisement.advertisementId ?? 0)
                                    },
                                    dislikeButtonTapped: {
                                        viewModel.dislikeAdvertisementTapped(advertisementId: advertisement.advertisementId ?? 0)
                                    }
                                )
                            }
                            if pair.count == 1 {
                                Spacer().frame(maxWidth: .infinity)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, NCConstants.Margins.large.rawValue)
            .padding(.top, NCConstants.Margins.extraLarge.rawValue)
        }
        .sheet(isPresented: $isFilterTapped) {
            FilterView(
                viewModel: FilterViewModel(
                    selectedRadioButton: viewModel.order,
                    selectedCheckBoxes: viewModel.conditions
                ),
                isFilterTapped: $isFilterTapped,
                applyFilters: { selectedCheckBoxes, selectedRadioButton in
                    viewModel.applyFiltersTapped(selectedCheckBoxes: selectedCheckBoxes, selectedRadioButton: selectedRadioButton)
                }
            )
            .presentationDetents([.fraction(0.95)])
            .presentationDragIndicator(.hidden)
        }
    }
}
