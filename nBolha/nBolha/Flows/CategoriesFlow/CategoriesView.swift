//
//  CategoriesView.swift
//  nBolha
//
//  Created by David Balažic on 11. 4. 24.
//

import SwiftUI
import nBolhaUI
import NChainUI

struct CategoriesView: View {
    @ObservedObject private var viewModel: CategoriesViewModel
    @State private var search = ""
    
    init(
        viewModel: CategoriesViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
       Text("Categories screen")
    }
}
