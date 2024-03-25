//
//  File.swift
//  
//
//  Created by Rok Črešnik on 21/08/2023.
//

import Foundation

extension Int {
    public func times(_ f: () -> ()) {
        var counter = 0
        while counter < self {
            f()
            counter += 1
        }
    }
}
