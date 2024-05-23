//
//  Globals.swift
//  nBolhaUI
//
//  Created by David Balažic on 26. 3. 24.
//

import Foundation

public typealias Action = () -> Void
public typealias TypedAction<T> = (T) -> Void

public enum SortBy: String {
    case newest = "Newest to oldest"
    case oldest = "Oldest to newest"
    case lowToHigh = "Price: low to high"
    case highToLow = "Price: high to low"
    
    public var backendValue: String {
        switch self {
        case .newest: return "NewToOld"
        case .oldest: return "OldToNew"
        case .lowToHigh: return "PriceLowToHigh"
        case .highToLow: return "PriceHighToLow"
        }
    }
}

public enum Condition: String, CaseIterable {
    case withTags = "New with tags"
    case withoutTags = "New without tags"
    case veryGood = "Very good"
    case satisfactory = "Satisfactory"
    
    public var backendValue: String {
        switch self {
        case .withTags: return "New_with_tags"
        case .withoutTags: return "New_without_tags"
        case .veryGood: return "Very_good"
        case .satisfactory: return "Satisfactory"
        }
    }
}
