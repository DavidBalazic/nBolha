//
//  TabBarView.swift
//  nBolha
//
//  Created by David Balažic on 5. 4. 24.
//

import SwiftUI
import NChainUI

struct TabBarView: View {
    @ObservedObject private var viewModel: HomeViewModel
    
    init(
        viewModel: HomeViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        TabView {
            HomeView(viewModel: viewModel)
                .tabItem {
                    Label("", image: .home)
                }
            
            NoConnectionView()
                .tabItem {
                    Label("", image: .categories)
                }
            
            NoConnectionView()
                .tabItem {
                    Label("", image: .add)
                }
            
            NoConnectionView()
                .tabItem {
                    Label("", image: .heart)
                }
            
            NoConnectionView()
                .tabItem {
                    Label("", image: .user)
                }
        }
        .accentColor(Color(UIColor.brandSecondary!))
        .background(Color(UIColor.background01!))
    }
}
