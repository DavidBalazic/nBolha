//
//  File.swift
//  
//
//  Created by Miha Šemrl on 23. 01. 24.
//

import Foundation
import SwiftUI

struct SwiftUITestView: View {
    @Binding private var inputText: String
    @FocusState private var focused: Bool
    
    var body: some View {
        SwiftUITextInput(
            title: "title text",
            type: .primary,
            text: inputText,
            isFocused: focused
        )
    }
}
