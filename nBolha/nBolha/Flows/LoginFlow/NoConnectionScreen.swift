//
//  NoConnectionScreen.swift
//  nBolha
//
//  Created by David Balažic on 25. 3. 24.
//

import SwiftUI

struct NoConnectionScreen: View {
    var body: some View {
        VStack(spacing: 24) {
            Image("Illustrations2")
            VStack(spacing: 12) {
                Text("No connection")
                    .font(.title)
                Text("No internet connection found. Check your connection or try again.")
                    .multilineTextAlignment(.center)
                    .fontWeight(.thin)
                    //.frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.bottom, 24)
            Button("Try again", action: tryAgain)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(Color(white: 1.0))
                .background(Color(red: 0.0, green: 0.2823529411764706, blue: 0.3764705882352941))
                .cornerRadius(5.0)
        }
        .padding(.horizontal, 16)
    }
}

func tryAgain() {
    
}
 
//#Preview {
//    NoConnectionScreen()
//}
