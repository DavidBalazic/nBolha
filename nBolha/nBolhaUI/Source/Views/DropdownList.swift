//
//  DropdownList.swift
//  nBolhaUI
//
//  Created by David Balažic on 13. 5. 24.
//

import Foundation
import NChainUI
import SwiftUI

public struct DropdownList: View {
    // MARK: - Variables
    private var text: String
    @Binding private var errorText: String?
    private let leadingIcon: Image?
    
    private var isError: Bool {
        errorText != nil
    }
    
    // MARK: - Init
    public init(
        text: String,
        errorText: Binding<String?>,
        leadingIcon: Image? = nil
    ) {
        self.text = text
        self._errorText = errorText
        self.leadingIcon = leadingIcon
    }
    
    // MARK: - Body
    public var body: some View {
        VStack(alignment: .leading,
               spacing: NCConstants.Margins.zero.rawValue) {
            ZStack(alignment: .bottom) {
                HStack(alignment: .center,
                       spacing: NCConstants.Margins.small.rawValue) {
                    leadingIcon?
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            width: 24,
                            height: 24,
                            alignment: .center
                        )
                    ZStack(alignment: .trailing) {
                        Color.clear
                            .contentShape(Rectangle())
                        
                        HStack {
                            Text(text)
                                .font(Font(UIFont.body02))
                                .foregroundColor(Color(.text02!))
                                .animation(.quickSmooth, value: isError)
                            Spacer()
                            Image(.downChevron)
                                .resizable()
                                .renderingMode(.original)
                                .frame(width: 24, height: 24)
                        }
                    }
                    .frame(height: 48)
                }
                       .padding(.horizontal, 12)
                       .padding(.horizontal, -2)
                       .overlay(RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(.outline03!), lineWidth: 1)
                        .frame(height: 48)
                       )
            }
            
            Rectangle()
                .foregroundColor(Color(.errorDefault!))
                .frame(height: 4)
                .cornerRadius(32, corners: [.bottomLeft, .bottomRight])
                .offset(y: -4)
                .opacity(isError ? 1 : 0)
                .animation(.quickSmooth, value: isError)
            
            Text(errorText ?? "")
                .font(Font(UIFont.caption01))
                .foregroundColor(Color(.errorDefault!))
                .background(Color.clear)
                .opacity(isError ? 1 : 0)
                .padding(.vertical, isError ? 8 : -10)
                .animation(.quickSmooth, value: isError)
                .padding(.leading, 12)
        }
               .padding(2)
    }
}
