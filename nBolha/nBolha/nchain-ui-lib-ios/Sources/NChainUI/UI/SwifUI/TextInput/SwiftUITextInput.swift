//
//  NCTextInputUI.swift
//
//
//  Created by Miha Šemrl on 17. 01. 24.
//

import SwiftUI

@available(iOS 16.0, *)
public struct SwiftUITextInput: View {
    public enum `Type` {
        case primary
        case password
        case description
    }
    
    // MARK: - Variables
    @Binding private var text: String
    @Binding private var errorText: String?
    private var isFocused: FocusState<Bool>.Binding
    @State private var isEditing = false
    private let title: String
    private let type: Type
    private let isEnabled: Bool
    private let leadingIcon: Image?
    
    private var isError: Bool {
        errorText != nil
    }
    
    private var shouldMove: Bool {
        isEditing || (!text.isEmpty)
    }
    
    private var titleColor: Color {
        if !isEnabled {
            return Color(.inverseOutline02)
        }
        if shouldMove {
            if !isEditing, !text.isEmpty {
                return Color(.text02)
            }
            return Color(.brandPrimary)
        }
        return Color(.text02)
    }
    
    private var borderColor: Color {
        if !isEnabled {
            return Color(.interactionPrimaryDisabled)
        }
        return isEditing ? Color(.brandPrimary) : Color(.outline03)
    }
    
    // MARK: - Init
    public init(
        title: String,
        type: Type,
        text: Binding<String>,
        errorText: Binding<String?>,
        isEnabled: Bool = true,
        isFocused: FocusState<Bool>.Binding,
        leadingIcon: Image? = nil
    ) {
        self._text = text
        self.title = title
        self.type = type
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
                    ZStack(alignment: self.type == .description ? .top : .leading) {
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
                            text: $text,
                            errorText: $errorText,
                            isEnabled: isEnabled,
                            type: type
                        )
                        .offset(y: title.isEmpty && self.type != .description ? -8 : 0)
                    }
                    .frame(height: self.type == .description ? 116 : 48)
                }
                
                       .padding(.horizontal, 12)
                       .overlay(isEditing ? RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(.inverseOutline02), lineWidth: 3)
                            .frame(height: self.type == .description ? 120 : 52) : nil
                       )
                       .padding(.horizontal, -2)
                       .overlay(RoundedRectangle(cornerRadius: isEditing ? 2 : 4)
                            .stroke(borderColor, lineWidth: 1)
                            .frame(height: self.type == .description ? 116 : 48)
                       )
            }
            .focused(isFocused)
            .onChange(of: isFocused.wrappedValue) { _ in
                isEditing = isFocused.wrappedValue
            }
            
            Rectangle()
                .foregroundColor(Color(.errorDefault))
                .frame(height: 4)
                .cornerRadius(32, corners: [.bottomLeft, .bottomRight])
                .offset(y: -4)
                .opacity(isError ? 1 : 0)
                .animation(.quickSmooth, value: isError)
            
            Text(errorText ?? "")
                .font(Font(UIFont.caption01))
                .foregroundColor(Color(.errorDefault))
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
        @Binding private var text: String
        @Binding private var errorText: String?
        @State private var showPassword = false
        private let type: SwiftUITextInput.`Type`
        private let isEditing: Bool
        private let isEnabled: Bool
        
        private var isError: Bool {
            errorText != nil
        }
        
        init(
            isEditing: Bool,
            text: Binding<String>,
            errorText: Binding<String?>,
            isEnabled: Bool = true,
            type: SwiftUITextInput.`Type`
        ) {
            self.isEditing = isEditing
            self._text = text
            self._errorText = errorText
            self.isEnabled = isEnabled
            self.type = type
        }
        
        private var defaultTextField: some View {
            TextField("", text: $text, axis: self.type == .description ? .vertical : .horizontal)
                .onChange(of: isEditing) { edit in
                    if edit {
                        errorText = nil
                    }
                }
                .padding(.bottom, type == .description ? 12 : 0)
        }
        
        var body: some View {
            if type == .primary || type == .description {
                defaultTextField
                    .styleInputView(
                        isEnabled: isEnabled,
                        isEditing: isEditing,
                        isError: isError
                    )
            } else {
                HStack {
                    if showPassword {
                        defaultTextField
                            .styleInputView(
                                isEnabled: isEnabled,
                                isEditing: isEditing,
                                isError: isError
                            )
                    } else {
                        SecureField("", text: $text)
//                            .offset(y: 8)
                            .onTapGesture {
                                errorText = nil
                            }
                            .styleInputView(
                                isEnabled: isEnabled,
                                isEditing: isEditing,
                                isError: isError
                            )
                    }
                }
                .overlay(alignment: .trailing, content: {
                    Image(showPassword ? .icnEyeReveal : .icnEye)
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 22, height: 16)
                        .onTapGesture {
                            if isEnabled {
                                showPassword.toggle()
                            }
                        }
                        .animation(.quickSmooth, value: isError)
                })
            }
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
            return Color(.inverseOutline02)
        }
        return isEditing ? Color(.text01) : Color(.text02)
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
