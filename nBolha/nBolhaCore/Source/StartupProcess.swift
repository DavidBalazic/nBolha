//
//  StartupService.swift
//  ComplexChinaCore
//
//  Created by Luka Pernousek on 9. 11. 23.
//

import Foundation

/// An abstraction for a predefined set of functionality, aimed to be ran once, at app startup.
public protocol StartupProcess {
    func run()
}
