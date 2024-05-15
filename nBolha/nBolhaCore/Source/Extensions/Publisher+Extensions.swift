//
//  Publisher+Extensions.swift
//  nBolhaCore
//
//  Created by David Balažic on 27. 3. 24.
//

import Combine

public extension Publisher where Output == String, Failure == Never {
    var notEmptyPublisher: AnyPublisher<
        Bool,
        Never
    > {
        self
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    var validEmailPublisher: AnyPublisher<Bool, Never> {
            map { email in
                let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
                let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
                return emailPredicate.evaluate(with: email)
            }.eraseToAnyPublisher()
    }
    var validPricePublisher: AnyPublisher<Bool, Never> {
        map { price in
            let numericPrice = price.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: ".")
            guard let priceDouble = Double(numericPrice) else {
                return false
            }
            return priceDouble <= 999999
        }.eraseToAnyPublisher()
    }
}

public extension Publisher where Self.Failure == Never {
    func assignNoRetain<Root>(
        to keyPath: ReferenceWritableKeyPath<Root, Self.Output>,
        on object: Root
    ) -> AnyCancellable where Root: AnyObject {
        self
            .sink { [weak object] value in
                object?[keyPath: keyPath] = value
            }
    }
}
