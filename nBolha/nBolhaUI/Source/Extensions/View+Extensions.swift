//
//  View+Extensions.swift
//  ComplexChinaUI
//
//  Created by Luka Pernousek on 14. 11. 23.
//

import SwiftUI

struct RoundedCorner: Shape {
    let radius: CGFloat
    let corners: UIRectCorner
    
    init(
        radius: CGFloat,
        corners: UIRectCorner = .allCorners
    ) {
        self.radius = radius
        self.corners = corners
    }

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

extension View {
    /// Convenince for wrapping up a SwiftUI View into UIKit friendly territory; `UIViewController`.
    public var asViewController: UIViewController {
        HostingController(rootView: self)
    }

    public func customized(for type: UITextContentType) -> some View {
        var keyboard: UIKeyboardType = .default
        switch type {
        case .emailAddress:
            keyboard = .emailAddress
        case .creditCardNumber, .postalCode, .oneTimeCode, .telephoneNumber:
            keyboard = .numberPad
        default:
            break
        }
        return self
            .textContentType(type)
            .keyboardType(keyboard)
    }

    public func onAppBackgrounded(
        _ closure: @escaping () -> Void
    ) -> some View {
        self.onReceive(
            NotificationCenter.default.publisher(
                for: UIApplication.willResignActiveNotification
            )
        ) { _ in
            closure()
        }
    }

    public func onAppForegrounded(
        _ closure: @escaping () -> Void
    ) -> some View {
        self.onReceive(
            NotificationCenter.default.publisher(
                for: UIApplication.didBecomeActiveNotification
            )
        ) { _ in
            closure()
        }
    }
    
    public func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
}

private struct BackgroundViewController: UIViewControllerRepresentable {
    func makeUIViewController(
        context: UIViewControllerRepresentableContext<BackgroundViewController>
    ) -> UIViewController {
        Controller()
    }

    func updateUIViewController(
        _ uiViewController: UIViewController,
        context: UIViewControllerRepresentableContext<BackgroundViewController>
    ) { }

    private class Controller: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .clear
        }

        override func willMove(toParent parent: UIViewController?) {
            super.willMove(toParent: parent)
            parent?.view?.backgroundColor = .clear
            parent?.modalPresentationStyle = .overCurrentContext
            parent?.modalTransitionStyle = .crossDissolve
        }
    }
}
