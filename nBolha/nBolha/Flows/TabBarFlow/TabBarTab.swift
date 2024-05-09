//
//  TabBarTab.swift
//  nBolha
//
//  Created by David Balažic on 16. 4. 24.
//

import Foundation
import UIKit
import Combine

final class TabBarTab {
    var bag = Set<AnyCancellable>()
    let item: Item
    
    @Published var selectedImage: UIImage?
    @Published var image: UIImage?
    
    init(item: Item) {
        self.item = item
        self.image = item.image
    }
    
    // MARK: - Item
    enum Item {
        case home
        case categories
        case wishlist
        case uploadItem
        
        var image: UIImage? {
            switch self {
            case .home:
                return .home
            case .categories:
                return .categories
            case .wishlist:
                return .wishlist
            case .uploadItem:
                return .uploadItem
            }
        }
        var tabBarIndex: Int {
            switch self {
            case .home:
                0
            case .categories:
                1
            case .wishlist:
                2
            case .uploadItem:
                3
            }
        }
    }
}
