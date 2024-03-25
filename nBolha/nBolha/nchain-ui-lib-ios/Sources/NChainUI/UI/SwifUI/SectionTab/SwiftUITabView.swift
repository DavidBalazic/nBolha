//
//  SwiftUITabView.swift
//
//
//  Created by Miha Šemrl on 29. 01. 24.
//

import Foundation

import SwiftUI

@available(iOS 15.0, *)
public struct SwiftUITabView<Item, Content>: View where Content: View, Item: SectionTabViewItem {
    @State private var selectedIndex = 0
    private let items: [Item]
    private let selectionChanged: TypedAction<Item>?
    private let content: (Item) -> Content
    private let tabBarStyle: SwiftUITabViewStyle
    
    public init(
        items: [Item],
        selectionChanged: TypedAction<Item>? = nil,
        @ViewBuilder content: @escaping (Item) -> Content,
        tabBarStyle: SwiftUITabViewStyle = tabViewDefaultStyle
    ) {
        self.items = items
        self.selectionChanged = selectionChanged
        self.content = content
        self.tabBarStyle = tabBarStyle
    }
    
    public var body: some View {
        VStack(
            spacing: NCConstants.Margins.small.rawValue
        ) {
            SwiftUITabBar(
                identifiers: items,
                selectedIndex: $selectedIndex,
                tabBarStyle: tabBarStyle
            )
            
            content(
                items[selectedIndex]
            )
            .transition(.opacity)
        }
        .animation(.quickSmooth, value: selectedIndex)
        .onChange(of: selectedIndex) {
            selectionChanged?(
                items[$0]
            )
        }
    }
    
    private struct SwiftUITabBar: View {
        @Binding private var selectedIndex: Int
        @Namespace private var namespace
        private let identifiers: [Item]
        private let tabBarStyle: SwiftUITabViewStyle
        
        init(
            identifiers: [Item],
            selectedIndex: Binding<Int>,
            tabBarStyle: SwiftUITabViewStyle
        ) {
            self.identifiers = identifiers
            self._selectedIndex = selectedIndex
            self.tabBarStyle = tabBarStyle
        }
        
        var body: some View {
            HStack(spacing: NCConstants.Margins.large.rawValue) {
                ForEach(
                    Array(identifiers.enumerated()), id: \.offset
                ) { index, identifier in
                    ZStack {
                        Text(identifier.title)
                            .textStyle(index == selectedIndex ?
                                       tabBarStyle.selectedFont : tabBarStyle.unselectedFont)
                            .foregroundStyle(index == selectedIndex ?
                                             tabBarStyle.selectedTextColor : tabBarStyle.unselectedTextColor)
                        VStack {
                            Spacer()
                            if index == selectedIndex {
                                Rectangle()
                                    .foregroundColor(tabBarStyle.selectedUnderlineColor)
                                    .frame(height: 2)
                                    .matchedGeometryEffect(
                                        id: "underline",
                                        in: namespace.self
                                    )
                            } else {
                                Rectangle()
                                    .foregroundColor(tabBarStyle.unselectedUnderlineColor)
                                    .frame(height: 2)
                            }
                        }
                    }
                    .background(index == selectedIndex ?
                                tabBarStyle.selectedBackgroundColor : tabBarStyle.unselectedBackgroundColor)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedIndex = index
                    }
                    .cornerRadius(NCConstants.Radius.small.rawValue, corners: [.topLeft, .topRight])
                }
                .animation(.quickSmooth, value: selectedIndex)
            }
            .frame(height: 48)
            .padding(.horizontal, NCConstants.Margins.small.rawValue)
        }
    }
}
