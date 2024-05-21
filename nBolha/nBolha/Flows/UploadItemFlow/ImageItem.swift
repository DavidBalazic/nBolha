//
//  ImageItem.swift
//  nBolha
//
//  Created by David Balažic on 10. 5. 24.
//

import SwiftUI
import NChainUI

struct ImageItem: View {
    @Binding var image: UIImage
    var onDelete: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 126, height: 116)
                .clipped()
                .cornerRadius(16)
            Button(action: onDelete) {
                Image(.x)
                    .renderingMode(.template)
                    .foregroundStyle(Color(.outline03!))
            }
            .padding(.top, NCConstants.Margins.extraSmall.rawValue)
            .padding(.trailing, NCConstants.Margins.extraSmall.rawValue)
        }
    }
}
