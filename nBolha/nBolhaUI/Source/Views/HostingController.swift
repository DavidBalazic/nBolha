//
//  HostingController.swift
//  ComplexChinaUI
//
//  Created by Luka Pernousek on 29. 11. 23.
//

import SwiftUI

public class HostingController<Content: View>: UIHostingController<Content>, HostingControllerProtocol {
    public var canPopViewController: (() -> Bool)?
    
    public override init(rootView: Content) {
        super.init(rootView: rootView)
        title = ""
    }

    @available(*, unavailable)
    public required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public protocol HostingControllerProtocol {
    var canPopViewController: (() -> Bool)? { get }
}
