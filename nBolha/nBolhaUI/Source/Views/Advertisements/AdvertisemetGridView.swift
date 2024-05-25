//
//  AdvertisemetGridView.swift
//  nBolhaUI
//
//  Created by David Balažic on 25. 5. 24.
//

import Foundation
import SwiftUI
import nBolhaNetworking
import NChainUI

public struct AdvertisementGridView: View {
    let advertisements: [Advertisement]
    let itemTapped: (Advertisement) -> Void
    let likeButtonTapped: (Advertisement) -> Void
    let dislikeButtonTapped: (Advertisement) -> Void
    
    public init(
        advertisements: [Advertisement],
        itemTapped: @escaping (Advertisement) -> Void,
        likeButtonTapped: @escaping (Advertisement) -> Void,
        dislikeButtonTapped: @escaping (Advertisement) -> Void
    ) {
        self.advertisements = advertisements
        self.itemTapped = itemTapped
        self.likeButtonTapped = likeButtonTapped
        self.dislikeButtonTapped = dislikeButtonTapped
    }

    public var body: some View {
        let pairs = advertisements.chunked(into: 2)
        ForEach(pairs, id: \.self) { pair in
            HStack(alignment: .top, spacing: NCConstants.Margins.large.rawValue) {
                ForEach(pair, id: \.advertisementId) { advertisement in
                    AdvertisementItemsView(
                        advertisement: advertisement,
                        itemTapped: {
                            itemTapped(advertisement)
                        },
                        likeButtonTapped: {
                            likeButtonTapped(advertisement)
                        },
                        dislikeButtonTapped: {
                            dislikeButtonTapped(advertisement)
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
