//
//  NCTabBarController.swift
//  Demo
//
//  Created by Rok Črešnik on 15/08/2023.
//

import UIKit
import NChainUI
import SwiftUI

/// NCTabBarController is created with two generic constraints:
/// - TabBarDisplayable defines the tabs that are being displayed
open class NCTabBarController<I: TabBarDisplayable>: UITabBarController,
                                                     UITabBarControllerDelegate {
    var items: [I] = []
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    func setupViewControllers() {
        delegate = self
        guard let items = I.allCases as? [I]
        else { return }
        
        viewControllers = items.map { item in
            let controller = item.controller
            let image = item.image
            let item = UITabBarItem(title: item.title,
                                    image: image,
                                    selectedImage: image)
            
            controller.tabBarItem = item
            controller.title = item.title
            let nvc = UINavigationController()
            nvc.show(controller, sender: nil)
            return nvc
        }
    }
}

class LibraryTabBarController: NCTabBarController<LibraryTabs> {}

// TODO: Move somewhere else

/// Protocol that defines the tabs title / image / class
public protocol TabBarDisplayable: CaseIterable {
    var title: String { get }
    var image: UIImage? { get }
    var controller: UIViewController { get }
}

enum LibraryTabs: String, TabBarDisplayable, CaseIterable {
    case images
    case pin
    case demo
    case textFields
    case checkboxes
    case buttons
    case swiftUI
    
    var title: String {
        return rawValue.capitalized
    }
    
    var image: UIImage? {
        switch self {
        case .pin:
            return .remove
            
        case .demo:
            return .add

        case .textFields:
            return .icnUser
            
        case .checkboxes:
            return .icnCheckbox
            
        case .buttons:
            return .icnCheckboxSelected
            
        case .images:
            return .icnCheckbox
            
        case .swiftUI:
            return .icnCheckbox
        }
    }
   
    var controller: UIViewController {
        switch self {
        case .pin: return PinVC()
        case .demo: return DemoVC()
        case .textFields: return LibraryInputsVC()
        case .checkboxes: return LibraryCheckboxesVC()
        case .buttons: return LibraryButtonsVC()
        case .images: return ImagesVC()
        case .swiftUI: return getViewController(view: SwiftUITestView())
        }
    }
}

func getViewController(view: any View) -> UIViewController {
    return view.asViewController
}

struct SwiftUITestView: View {
    @State private var notification: SwiftUINotificationModel? = nil

    var body: some View {
        Button {
            notification = SwiftUINotificationModel(
                type: .error,
                title: "Toast info",
                message: "Toast message",
                duration: 0,
                side: .bottom
            )
        } label: {
            Text("Run")
        }.notification(notificationModel: $notification)
    }
}
