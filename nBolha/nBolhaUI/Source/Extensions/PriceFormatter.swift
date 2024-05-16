//
//  PriceFormater.swift
//  nBolha
//
//  Created by David Balažic on 7. 5. 24.
//

import Foundation

struct PriceFormatter {
    static func formatPrice(_ price: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "EUR"
        return formatter.string(from: NSNumber(value: price)) ?? "\(price)"
    }
}
