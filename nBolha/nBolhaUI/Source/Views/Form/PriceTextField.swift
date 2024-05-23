//
//  PriceTextField.swift
//  nBolhaUI
//
//  Created by David Balažic on 23. 5. 24.
//

import SwiftUI
import NChainUI

@available(iOS 16.0, *)
public struct PriceTextInput: View {
    // MARK: - Variables
    @Binding private var amount: Double?
    @Binding private var errorText: String?
    private var isFocused: FocusState<Bool>.Binding
    @State private var isEditing = false
    private let title: String
    private let isEnabled: Bool
    private let leadingIcon: Image?
    
    private var isError: Bool {
        errorText != nil
    }
    
    private var shouldMove: Bool {
        isEditing || (amount != nil)
    }
    
    private var titleColor: Color {
        if !isEnabled {
            return Color(.inverseOutline02!)
        }
        if shouldMove {
            if !isEditing, amount != nil {
                return Color(.text02!)
            }
            return Color(.brandPrimary!)
        }
        return Color(.text02!)
    }
    
    private var borderColor: Color {
        if !isEnabled {
            return Color(.interactionPrimaryDisabled!)
        }
        return isEditing ? Color(.brandPrimary!) : Color(.outline03!)
    }
    
    // MARK: - Init
    public init(
        title: String,
        amount: Binding<Double?>,
        errorText: Binding<String?>,
        isEnabled: Bool = true,
        isFocused: FocusState<Bool>.Binding,
        leadingIcon: Image? = nil
    ) {
        self._amount = amount
        self.title = title
        self._errorText = errorText
        self.isEnabled = isEnabled
        self.isFocused = isFocused
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
                    ZStack(alignment: .leading) {
                        Color.clear
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if !isFocused.wrappedValue {
                                    isFocused.wrappedValue = true
                                }
                            }
                        
                        Text(title)
                            .foregroundColor(titleColor)
                            .scaleEffect(shouldMove ? 1 : 1)
                            .offset(y: shouldMove ? -11 : 0)
                            .font(shouldMove ? Font(UIFont.caption01) : Font(UIFont.body02))
                            .animation(.quickSmooth, value: shouldMove)
                            .animation(.quickSmooth, value: isError)
                            .transformEffect(.identity)
                        
                        InputField(
                            isEditing: isEditing,
                            amount: $amount,
                            errorText: $errorText,
                            isEnabled: isEnabled
                        )
                        .offset(y: -8)
                    }
                    .frame(height: 48)
                }
                
                       .padding(.horizontal, 12)
                       .overlay(isEditing ? RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(.inverseOutline02!), lineWidth: 3)
                            .frame(height: 52) : nil
                       )
                       .padding(.horizontal, -2)
                       .overlay(RoundedRectangle(cornerRadius: isEditing ? 2 : 4)
                            .stroke(borderColor, lineWidth: 1)
                            .frame(height: 48)
                       )
            }
            .focused(isFocused)
            .onChange(of: isFocused.wrappedValue) { _ in
                isEditing = isFocused.wrappedValue
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
    
    // MARK: - InputField
    private struct InputField: View {
        @Binding private var amount: Double?
        @Binding private var errorText: String?
        @State private var showPassword = false
        private let isEditing: Bool
        private let isEnabled: Bool
        
        private var isError: Bool {
            errorText != nil
        }
        
        init(
            isEditing: Bool,
            amount: Binding<Double?>,
            errorText: Binding<String?>,
            isEnabled: Bool = true
        ) {
            self.isEditing = isEditing
            self._amount = amount
            self._errorText = errorText
            self.isEnabled = isEnabled
        }
        
        private var defaultTextField: some View {
            TextField("", value: $amount, format: .number.precision(.fractionLength(2)))
                .onChange(of: isEditing) { edit in
                    if edit {
                        errorText = nil
                    }
                }
        }
        
        var body: some View {
            defaultTextField
                .styleInputView(
                    isEnabled: isEnabled,
                    isEditing: isEditing,
                    isError: isError
                )
        }
    }
}

private struct InputViewStyleModifier: ViewModifier {
    private let isEnabled: Bool
    private let isEditing: Bool
    private let isError: Bool
    
    init(
        isEnabled: Bool = true,
        isEditing: Bool,
        isError: Bool
    ) {
        self.isEnabled = isEnabled
        self.isEditing = isEditing
        self.isError = isError
    }
    
    private var textColor: Color {
        if !isEnabled {
            return Color(.inverseOutline02!)
        }
        return isEditing ? Color(.text01!) : Color(.text02!)
    }
    
    func body(content: Content) -> some View {
        content
            .autocorrectionDisabled(true)
            .disabled(!isEnabled)
            .font(Font(UIFont.body02))
            .offset(y: 8)
            .foregroundColor(textColor)
            .animation(.quickSmooth, value: isError)
    }
}

extension View {
    func styleInputView(isEnabled: Bool = true, isEditing: Bool, isError: Bool) -> some View {
        modifier(
            InputViewStyleModifier(
                isEnabled: isEnabled,
                isEditing: isEditing,
                isError: isError
            )
        )
    }
}
