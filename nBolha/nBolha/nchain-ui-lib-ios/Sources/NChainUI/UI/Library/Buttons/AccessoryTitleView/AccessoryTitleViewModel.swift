//
//  File.swift
//  
//
//  Created by Rok Črešnik on 17/08/2023.
//

import Foundation

public struct AccessoryTitleViewModel: ViewModel {
    public var title: NCLabelViewModel?
    public var leading: NCImageViewModel?
    public var trailing: NCImageViewModel?
    
    public init(title: NCLabelViewModel? = nil,
                leading: NCImageViewModel? = nil,
                trailing: NCImageViewModel? = nil) {
        self.title = title
        self.leading = leading
        self.trailing = trailing
    }
}
