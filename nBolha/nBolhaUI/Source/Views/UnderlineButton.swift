//
//  UnderlineButton.swift
//  nBolhaUI
//
//  Created by David Balažic on 26. 3. 24.
//

import SwiftUI

struct UnderlineButton: View {
    private var text: String?
    private let tapped: Action
    private var font: UIFont
    private var color: UIColor

    public init(
        text: String? = nil,
        tapped: @escaping Action,
        font: UIFont,
        color: UIColor
    ) {
        self.text = text
        self.tapped = tapped
        self.font = font
        self.color = color
    }

    var body: some View {
        Button{
            tapped()
        } label: {
            if let text {
                Text(text)
                    .font(Font(font))
                    .underline(true)
                    .foregroundStyle(Color(color))
            }
        }
    }
}

//#Preview {
//    UnderlineButton()
//}
