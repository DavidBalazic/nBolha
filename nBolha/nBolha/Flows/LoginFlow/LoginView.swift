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
    private var mainSpacing: CGFloat {
        let screenHeight = UIScreen.main.bounds.height

        if screenHeight < 700 {
            return 16
        } else if screenHeight >= 700 && screenHeight <= 900 {
            return 44
        } else {
            return 60
        }
    }

    init(
        viewModel: LoginViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: mainSpacing) {
                Image(.logo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 223, height: 21)
                    .padding(.top, NCConstants.Margins.extraLarge.rawValue)
                VStack(spacing: NCConstants.Margins.medium.rawValue) {
                    Text("Welcome")
                        .font(Font(UIFont.title05))
                        .foregroundStyle(Color(UIColor.text01!))
                    Text("To log in, please provide your company email address and password.")
                        .font(Font(UIFont.body03))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color(UIColor.text02!))
                        .padding(.horizontal, 39)
                }
                Image(.illustrations)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 159, height: 159)
                
                VStack(spacing: NCConstants.Margins.large.rawValue) {
                    SwiftUITextInput(
                        title: "Email",
                        type: .primary,
                        text: $viewModel.email,
                        errorText: isEmailFocused ? .constant(nil) : $viewModel.errorEmailText,
                        isFocused: $isEmailFocused
                    )
                    SwiftUITextInput(
                        title: "Password",
                        type: .password,
                        text: $viewModel.password,
                        errorText: isPasswordFocused ? .constant(nil) : $viewModel.errorPasswordText,
                        isFocused: $isPasswordFocused
                    )
                }
                VStack(spacing: mainSpacing + NCConstants.Margins.extraSmall.rawValue) {
                    SwiftUIButton(
                        text: "Log in",
                        tapped: {
                            Task { await viewModel.loginTapped() }
                            isEmailFocused = false
                            isPasswordFocused = false
                        }
                    )
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
}

//#Preview {
//    LoginView()
//}
