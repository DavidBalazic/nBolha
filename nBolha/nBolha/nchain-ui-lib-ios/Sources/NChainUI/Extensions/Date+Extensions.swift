//
//  Date+Extensions.swift
//
//
//  Created by Miha Šemrl on 28. 02. 24.
//

import Foundation

extension Date {
    func toString(_ format: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
