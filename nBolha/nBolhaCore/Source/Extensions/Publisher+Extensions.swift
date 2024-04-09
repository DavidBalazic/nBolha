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
