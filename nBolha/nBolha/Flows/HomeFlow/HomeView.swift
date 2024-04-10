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
            Spacer().frame(height: NCConstants.Margins.medium.rawValue)
            VStack(spacing: NCConstants.Margins.extraLarge.rawValue) {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 223, height: 21)
                SearchBar(text: $search)
                    .padding(.bottom, NCConstants.Margins.extraLarge.rawValue)
            }
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("Recently viewed")
                        .textStyle(.subtitle02)
                        .foregroundStyle(Color(UIColor.brandTertiary!))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    EmptyRecentlyViewedView(viewModel: viewModel)
                    Text("Recently added")
                        .textStyle(.subtitle02)
                        .foregroundStyle(Color(UIColor.brandTertiary!))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    EmptyRecentlyAddedView()
                }
            }
            .padding(.horizontal, NCConstants.Margins.large.rawValue)
        }
    }
}
