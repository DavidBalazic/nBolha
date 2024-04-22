//
//  LikeButton.swift
//  nBolhaUI
//
//  Created by David Balažic on 10. 4. 24.
//

import SwiftUI
import NChainUI

public struct LikeButton: View {
    @Binding var isLiked: Bool
    let likedImage: UIImage
    let dislikedImage: UIImage
    
    public init(
        isLiked: Binding<Bool>,
        likedImage: UIImage,
        dislikedImage: UIImage
    ) {
        self._isLiked = isLiked
        self.likedImage = likedImage
        self.dislikedImage = dislikedImage
    }
    
    public var body: some View {
        Button(action: {
            isLiked.toggle()
        }) {
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: NCConstants.Margins.extraLarge.rawValue, height: NCConstants.Margins.extraLarge.rawValue)
                    .shadow(radius: 36, x: 0, y: NCConstants.Margins.small.rawValue)
                Image(uiImage: isLiked ? likedImage : dislikedImage)
            }
        }
        .padding(.top, NCConstants.Margins.small.rawValue)
        .padding(.trailing, NCConstants.Margins.small.rawValue)
    }
}