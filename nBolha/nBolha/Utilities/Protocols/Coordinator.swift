//
//  Coordinator.swift
//  nBolha
//
//  Created by Adel Burekovic on 20. 03. 24.
//
import UIKit

protocol Coordinator {
    func start() -> UIViewController
}

protocol CompletableCoordinator: Coordinator {
    associatedtype FlowResult
}
