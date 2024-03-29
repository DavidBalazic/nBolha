//
//  WindowNotificationsView.swift
//  nBolhaUI
//
//  Created by David Balažic on 28. 3. 24.
//

import SwiftUI
import nBolhaCore

struct WindowNotificationsView: View {
    @ObservedObject private var viewModel: WindowNotificationViewModel

    @State private var dragOffset: CGSize = .zero
    @State private var viewTopAndHeight = TopAndHeight(
        top: 0,
        height: 0
    )
    
    private var shownOffset: CGSize {
        guard !viewModel.isShown,
                viewTopAndHeight.height > 0 else { return .zero }

        return .init(
            width: 0,
            height: -(viewTopAndHeight.top + viewTopAndHeight.height)
        )
    }

    init(
        viewModel: WindowNotificationViewModel
    ) {
        self.viewModel = viewModel
    }

    var dragGesture: some Gesture {
        DragGesture()
            .onChanged {
                dragOffset.height = min($0.translation.height, 0)
            }
            .onEnded {
                if -$0.translation.height > 100
                        || -$0.velocity.height > 600 {
                    viewModel.dismissNotification()
                } else {
                    withAnimation {
                        dragOffset = .zero
                    }
                }
            }
    }

    var body: some View {
        NotificationView(notification: viewModel.notification) {
            viewModel.dismissNotification()
        }
        .background {
            GeometryReader { geom in
                let frame = geom.frame(in: .global)
                Color.clear.preference(
                    key: TopAndHeightPreferenceKey.self,
                    value: .init(top: frame.origin.y, height: frame.height)
                )
            }
        }
        .offset(dragOffset)
        .offset(shownOffset)
        .gesture(dragGesture)
        .disabled(!viewModel.isShown)
        .onPreferenceChange(TopAndHeightPreferenceKey.self) {
            if viewTopAndHeight.height == 0 && $0.height > 0 {
                viewTopAndHeight = $0
                viewModel.willAppear()
            }
        }
    }
}

private struct TopAndHeight: Equatable {
    let top: CGFloat
    let height: CGFloat
}

private struct TopAndHeightPreferenceKey: PreferenceKey {
    static var defaultValue: TopAndHeight = .init(top: 0, height: 0)

    static func reduce(value: inout TopAndHeight, nextValue: () -> TopAndHeight) {
    }
}

//#Preview {
//    WindowNotificationsView(
//        viewModel: WindowNotificationViewModel(notification: .init(type: .info, text: "Hello world"))
//    )
//}
