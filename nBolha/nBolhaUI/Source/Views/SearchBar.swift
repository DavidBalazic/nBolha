//
//  SearchBar.swift
//  nBolhaUI
//
//  Created by David Balažic on 9. 4. 24.
//

import SwiftUI
import NChainUI

public struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
    
    public init(
        text: Binding<String>
    ) {
        self._text = text
    }
 
    public var body: some View {
        HStack {
            TextField("Search", text: $text)
                .font(Font(UIFont.body01))
                .foregroundStyle(Color(UIColor.text02!))
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(UIColor.background03!))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(UIColor.icons03!))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                 
                        if isEditing && text.count > 0 {
                            Button(action: {
                                withAnimation {
                                    self.text = ""
                                }
                            })
                            {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                                    .transition(.opacity)
                            }
                        }
                    }
                )
                .padding(.horizontal, NCConstants.Margins.large.rawValue)
                .onTapGesture {
                    withAnimation {
                        self.isEditing = true
                    }
                }
 
            if isEditing {
                Button(action: {
                    withAnimation {
                        self.isEditing = false
                        self.text = ""
                    }
                    // Dismiss the keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) 
                {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
            }
        }
    }
}
