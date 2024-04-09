//
//  LoginView.swift
//  nBolha
//
//  Created by David Balažic on 22. 3. 24.
//

import SwiftUI
import nBolhaUI
import NChainUI

struct LoginView: View {
    @ObservedObject private var viewModel: LoginViewModel
    @FocusState private var isEmailFocused: Bool
    @FocusState private var isPasswordFocused: Bool

    init(
        viewModel: LoginViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: NCConstants.Margins.veryHuge.rawValue) {
            Image(.logo)
            VStack(spacing: NCConstants.Margins.medium.rawValue) {
                Text("Welcome")
                    .font(Font(UIFont.title05))
                    .foregroundStyle(Color(UIColor.text01!))
                Text("To log in, please provide your company email address and password.")
                    .font(Font(UIFont.body03))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color(UIColor.text02!))
                    
            }
            Image(.illustrations)
            VStack(spacing: NCConstants.Margins.large.rawValue) {
                SwiftUITextInput(
                    title: "Email",
                    type: .primary,
                    text: $viewModel.email,
                    errorText: $viewModel.errorEmailText,
                    isFocused: $isEmailFocused
                )
                SwiftUITextInput(
                    title: "Password",
                    type: .password,
                    text: $viewModel.password,
                    errorText: $viewModel.errorPasswordText,
                    isFocused: $isPasswordFocused
                )
            }
            VStack(spacing: NCConstants.Margins.giant.rawValue) {
                SwiftUIButton(
                    text: "Log in",
                    tapped: {
                        viewModel.loginTapped()
                    }
                )
                .disabled(!viewModel.isButtonEnabled)
                TermsAndConditionsView(
                    termsTapped: viewModel.termsTapped,
                    privacyTapped: viewModel.privacyTapped,
                    textFont: UIFont.body03,
                    buttonFont: UIFont.underline02,
                    textColor: UIColor.text01!,
                    buttonColor: UIColor.link01!
                )
            }
        }
        .padding(.horizontal, NCConstants.Margins.large.rawValue)
    }
}

//#Preview {
//    LoginView()
//}
