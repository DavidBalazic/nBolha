//
//  String+Extensions.swift
//  nBolhaUI
//
//  Created by David Balažic on 24. 5. 24.
//

import Foundation
import NChainUI
import UIKit

extension String {
    public func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}
