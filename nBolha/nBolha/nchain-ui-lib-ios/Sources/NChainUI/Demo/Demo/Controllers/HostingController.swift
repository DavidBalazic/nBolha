//
//  HostingController.swift
//  Demo
//
//  Created by Miha Šemrl on 19. 01. 24.
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


extension View {
    /// Convenince for wrapping up a SwiftUI View into UIKit friendly territory; `UIViewController`.
    public var asViewController: UIViewController {
        HostingController(rootView: self)
    }
}
