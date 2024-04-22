//
//  HomeView.swift
//  nBolha
//
//  Created by David Balažic on 5. 4. 24.
//

import SwiftUI
import NChainUI
import nBolhaUI

struct HomeView: View {
    @ObservedObject private var viewModel: HomeViewModel
    @State private var search = ""
    
    init(
        viewModel: HomeViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            SearchBar(text: $search)
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("Recently viewed")
                        .textStyle(.subtitle02)
                        .foregroundStyle(Color(UIColor.brandTertiary!))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if viewModel.advertisements.isEmpty {
                        EmptyRecentlyViewedView(viewModel: viewModel)
                    } else {
                        //TODO: implement
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack(spacing: NCConstants.Margins.large.rawValue) {
//                                ForEach(viewModel.advertisements.suffix(6), id: \.id) { advertisement in
//                                    RecentlyViewedView(advertisement: advertisement)
//                                }
//                            }
//                        }
                        EmptyRecentlyViewedView(viewModel: viewModel)
                    }
                    Text("Recently added")
                        .textStyle(.subtitle02)
                        .foregroundStyle(Color(UIColor.brandTertiary!))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if viewModel.advertisements.isEmpty {
                        EmptyRecentlyAddedView()
                    } else {
                        let pairs = viewModel.advertisements.suffix(6).reversed().chunked(into: 2)
                        ForEach(pairs, id: \.self) { pair in
                            HStack(alignment: .top, spacing: NCConstants.Margins.large.rawValue) {
                                ForEach(pair, id: \.advertisement_id) { advertisement in
                                    RecentlyAddedView(advertisement: advertisement)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, NCConstants.Margins.large.rawValue)
        }
    }
}
