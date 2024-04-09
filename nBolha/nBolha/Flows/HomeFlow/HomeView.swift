//
//  HomeView.swift
//  nBolha
//
//  Created by David Balažic on 5. 4. 24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var viewModel: HomeViewModel
    
    init(
        viewModel: HomeViewModel
    ) {
        self.viewModel = viewModel
    }
    var body: some View {
        Text("Home Screen")
    }
}

//#Preview {
//    HomeView()
//}
