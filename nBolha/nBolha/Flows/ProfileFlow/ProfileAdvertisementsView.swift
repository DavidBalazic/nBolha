//
//  ProfileAdvertisementsView.swift
//  nBolha
//
//  Created by David Balažic on 17. 5. 24.
//

import SwiftUI
import NChainUI
import nBolhaUI
import nBolhaNetworking

struct ProfileAdvertisementsView: View {
    let advertisement: Advertisement
    let itemTapped: () -> Void
    let deleteItemTapped: () -> Void
    
    init(
        advertisement: Advertisement,
        itemTapped: @escaping () -> Void,
        deleteItemTapped: @escaping () -> Void
    ) {
        self.advertisement = advertisement
        self.itemTapped = itemTapped
        self.deleteItemTapped = deleteItemTapped
    }
    
    public var body: some View {
        Button(action: {
            itemTapped()
        }) {
            VStack(spacing: NCConstants.Margins.small.rawValue) {
                ZStack(alignment: .topTrailing) {
                    if let imageObject = advertisement.images?.first, let imageURL = imageObject.fullImageURL {
                        AsyncImage(url: imageURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 166)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(
                                cornerRadius: NCConstants.Radius.small.rawValue,
                                style: .continuous
                            )
                            .stroke(Color(UIColor.outline02!), lineWidth: 1)
                        )
                    }
                    HStack {
                        Button(action: {
                            
                        }) {
                            Image(.edit)
                        }
                        .padding(.top, NCConstants.Margins.small.rawValue)
                        .padding(.leading, NCConstants.Margins.small.rawValue)
                        Spacer()
                        Button(action: {
                            deleteItemTapped()
                        }) {
                            Image(.delete)
                        }
                        .padding(.top, NCConstants.Margins.small.rawValue)
                        .padding(.trailing, NCConstants.Margins.small.rawValue)
                    }
                }
                VStack(alignment: .leading) {
                    Text(advertisement.title ?? "Title not provided")
                        .textStyle(.subtitle02)
                        .foregroundStyle(Color(UIColor.text01!))
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(PriceFormatter.formatPrice(advertisement.price ?? 0))
                        .textStyle(.body02)
                        .foregroundStyle(Color(UIColor.text02!))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}
