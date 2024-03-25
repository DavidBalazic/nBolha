//
//  LoginView.swift
//  nBolha
//
//  Created by David Balažic on 22. 3. 24.
//

import SwiftUI
import nBolhaUI

struct LoginView: View {
//    @State private var email: String = ""
//    @State private var password: String = ""
    @ObservedObject private var viewModel: LoginViewModel

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 44) {
            Image("logo")
            VStack(spacing: 12) {
                Text("Welcome")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.semibold)
                Text("To log in, please provide your company email address and password.")
                    .font(.subheadline)
                    .fontWeight(.thin)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 39)
            }
            Image("Illustrations")
            VStack(spacing: 16) {
                TextField("Email", text: $viewModel.email)
                SecureField("Password", text: $viewModel.password)
            }
            .textFieldStyle(.roundedBorder)
            VStack(spacing: 48) {
                Button("Log in", action: viewModel.loginButtonTapped)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(Color(white: 1.0))
                    .background(Color(red: 0.0, green: 0.2823529411764706, blue: 0.3764705882352941))
                    .cornerRadius(5.0)
                
                Text("By continuing, I agree to the Terms & Conditions & Privacy policy.")
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.horizontal, 16)
    }
}

func logIn() {
    
}


//#Preview {
//    LoginView()
//}
