//
//  TestView2.swift
//  nBolha
//
//  Created by Urh Kraner on 22. 03. 24.
//

import SwiftUI

struct TestView2: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack(spacing: 44) {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .background(.red)
            VStack(spacing: 12) {
                Text(title)
                Text(value)
            }.background(.green)
        }.background(.blue)
    }
}

#Preview {
    TestView2(title: "test", value: "test")
}
