//
//  SectionTabViewItem.swift
//
//
//  Created by Miha Šemrl on 30. 01. 24.
//

import Foundation

public protocol SectionTabViewItem: Identifiable, Hashable {
    var title: String { get }
}

extension SectionTabViewItem where Self: RawRepresentable, RawValue == String {
    public var id: String { rawValue }
}
