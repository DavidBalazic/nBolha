//
//  TermsAndConditionView.swift
//  nBolhaUI
//
//  Created by David Balažic on 26. 3. 24.
//

import SwiftUI

public struct TermsAndConditionsView: View {
    private let termsTapped: Action
    private let privacyTapped: Action
    private var textFont: UIFont
    private var buttonFont: UIFont
    private var textColor: UIColor
    private var buttonColor: UIColor

    public init(
        termsTapped: @escaping Action,
        privacyTapped: @escaping Action,
        textFont: UIFont,
        buttonFont: UIFont,
        textColor: UIColor,
        buttonColor: UIColor
    ) {
        self.termsTapped = termsTapped
        self.privacyTapped = privacyTapped
        self.textFont = textFont
        self.buttonFont = buttonFont
        self.textColor = textColor
        self.buttonColor = buttonColor
    }
    
    public var body: some View {
        VStack(spacing: 4) {
            Text("By continuing, I agree to the ")
                .font(Font(textFont))
                .foregroundStyle(Color(textColor))
                 
            HStack(spacing: 4) {
                UnderlineButton(
                    text: "Terms & Conditions",
                    tapped: termsTapped,
                    font: buttonFont,
                    color: buttonColor
                )
                Text("&")
                    .font(Font(textFont))
                    .foregroundStyle(Color(textColor))
                UnderlineButton(
                    text: "Privacy policy",
                    tapped: privacyTapped,
                    font: buttonFont,
                    color: buttonColor
                )
                
            }
        }
    }
}

//#Preview {
//    TermsAndConditionView()
//}
