//
//  PassthroughSubject+Extensions.swift
//  nBolhaCore
//
//  Created by David Balažic on 2. 4. 24.
//

import Foundation
import Combine

public extension PassthroughSubject where Output == Bool, Failure == Never {
  func errorMessageOnLossOfFocusPublisher(
    textValidation: AnyPublisher<Bool, Never>,
    errorMessage: String
  ) -> AnyPublisher<String?, Never> {
    self
      .combineLatest(textValidation)
      .map { isFocused, isTextValid in
        guard !isFocused else {
          return nil
        }
        return isTextValid ? nil : errorMessage
      }
      .eraseToAnyPublisher()
  }
}
