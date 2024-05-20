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
    case newest = "NewToOld"
    case oldest = "OldToNew"
    case lowToHigh = "PriceLowToHigh"
    case highToLow = "PriceHighToLow"
}

public enum Condition: String, CaseIterable {
    case withTags = "New_with_tags"
    case withoutTags = "New_without_tags"
    case veryGood = "Very_good"
    case satisfactory = "Satisfactory"
}
