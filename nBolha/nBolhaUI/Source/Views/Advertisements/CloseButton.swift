//
//  CloseButton.swift
//  nBolhaUI
//
//  Created by David Balažic on 22. 4. 24.
//

import SwiftUI
import NChainUI

public struct CloseButton: View {
    let xImage: UIImage
    let action: () -> Void
    
    public init(
        xImage: UIImage,
        action: @escaping () -> Void
    ) {
        self.xImage = xImage
        self.action = action
    }
    
    public var body: some View {
        Button(action: action)
        {
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: NCConstants.Margins.extraLarge.rawValue, height: NCConstants.Margins.extraLarge.rawValue)
                    .shadow(radius: 36, x: 0, y: NCConstants.Margins.small.rawValue)
                Image(uiImage: xImage)
            }
        }
        .padding(.top, NCConstants.Margins.large.rawValue)
        .padding(.trailing, NCConstants.Margins.large.rawValue)
    }
}
