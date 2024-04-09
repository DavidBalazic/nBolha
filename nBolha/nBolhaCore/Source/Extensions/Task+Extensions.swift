//
//  Task+Extensions.swift
//  nBolhaCore
//
//  Created by David Balažic on 28. 3. 24.
//

extension Task where Failure == Error {
    @discardableResult
    public static func delayed(
        byTimeInterval delayInterval: TimeInterval,
        priority: TaskPriority? = nil,
        operation: @escaping @Sendable () async throws -> Success
    ) -> Task {
        Task(priority: priority) {
            let delay = UInt64(delayInterval * 1_000_000_000)
            try await Task<Never, Never>.sleep(nanoseconds: delay)
            return try await operation()
        }
    }
}
