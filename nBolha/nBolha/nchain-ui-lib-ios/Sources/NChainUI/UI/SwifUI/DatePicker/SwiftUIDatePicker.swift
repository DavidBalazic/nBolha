//
//  SwiftUIDatePicker.swift
//
//
//  Created by Miha Šemrl on 19. 02. 24.
//

import SwiftUI

@available(iOS 15.0, *)
public struct SwiftUIDatePicker: View {
    @Binding private var startDate: Date?
    @Binding private var endDate: Date?
    @State private var selectedIndex = 0
    
    private var dateFormat: DateFormatter
    private var startTitle: String
    private var endTitle: String?
    private var style: SwiftUIDatePickerStyle
    private var errorText: String?
    private var placeHolder: String?
    
    public init(
        startTitle: String,
        startDate: Binding<Date?>,
        endTitle: String? = nil,
        endDate: Binding<Date?> = .constant(nil),
        dateFormat: DateFormatter = DateFormatter(),
        style: SwiftUIDatePickerStyle? = nil,
        errorText: String? = nil,
        placeHolder: String? = nil
    ) {
        self._startDate = startDate
        self.startTitle = startTitle
        self._endDate = endDate
        self.endTitle = endTitle
        self.dateFormat = dateFormat
        self.style = style ?? SwiftUIDatePickerStyle(
            titleFont: .caption01,
            titleColor: Color(.text02),
            dateFont: .body02,
            dateColor: Color(.text02),
            borderColor: Color(.outline03),
            iconColor: Color(.icons03)
        )
        self.errorText = errorText
        self.placeHolder = placeHolder
        
        if self.dateFormat.dateFormat.isEmpty {
            self.dateFormat.dateFormat = "dd MMM, yyyy"
        }
    }
    
    public var body: some View {
        VStack(alignment: .leading,
               spacing: NCConstants.Margins.zero.rawValue) {
            HStack(
                spacing: NCConstants.Margins.zero.rawValue
            ) {
                DateHolderView(
                    date: $startDate,
                    selectedIndex: $selectedIndex,
                    index: 1,
                    title: startTitle,
                    dateFormat: dateFormat,
                    style: style,
                    placeHolder: placeHolder
                )
                if let endTitle {
                    DateHolderView(
                        date: $endDate,
                        selectedIndex: $selectedIndex,
                        index: 2,
                        title: endTitle,
                        dateFormat: dateFormat,
                        style: style,
                        placeHolder: placeHolder
                    )
                }
            }
            .frame(maxWidth: .infinity)
            .overlay {
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: NCConstants.Radius.small.rawValue)
                        .strokeBorder(style.borderColor, lineWidth: 1)
                    
                    let errorLineWidth: CGFloat = 3
                    RoundedRectangle(cornerRadius: NCConstants.Radius.small.rawValue)
                        .strokeBorder(Color(.errorDefault), lineWidth: errorLineWidth)
                        .clipShape(BottomAlignedRectangleShape(height: errorLineWidth))
                        .opacity(errorText != nil ? 1 : 0)
                        .animation(.quickSmooth, value: errorText)
                    
                }
            }
            
            Text(errorText ?? "")
                .frame(height: errorText != nil ? nil : 0)
                .font(Font(UIFont.caption01))
                .foregroundColor(Color(.errorDefault))
                .background(Color.clear)
                .opacity(errorText != nil ? 1 : 0)
                .animation(.quickSmooth, value: errorText)
                .padding(.top, errorText != nil ? NCConstants.Margins.small.rawValue : 0)
                .padding(.leading, NCConstants.Margins.medium.rawValue)
        }
    }
    
    // MARK: - Single date picker
    private struct DateHolderView: View {
        @Binding var date: Date?
        @Binding var selectedIndex: Int
        @State private var datePickerDate: Date = Date()
        private let index: Int
        private let title: String
        private let dateFormat: DateFormatter
        private let style: SwiftUIDatePickerStyle
        private let placeHolder: String
        
        init(
            date: Binding<Date?>,
            selectedIndex: Binding<Int>,
            index: Int,
            title: String,
            dateFormat: DateFormatter,
            style: SwiftUIDatePickerStyle,
            placeHolder: String?
        ) {
            self._date = date
            self._selectedIndex = selectedIndex
            self.index = index
            self.title = title
            self.dateFormat = dateFormat
            self.style = style
            self.placeHolder = placeHolder ?? "Pick a date"
        }
        
        var body: some View {
            ZStack() {
                HStack() {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(title)
                            .foregroundColor(style.titleColor)
                            .font(Font(style.titleFont))
                        Text(date?.toString(dateFormat.dateFormat) ?? placeHolder)
                            .foregroundColor(style.dateColor)
                            .font(Font(style.dateFont))
                    }
                    Image(.icnCalendar)
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            width: NCConstants.IconSize.huge.rawValue,
                            height: NCConstants.IconSize.huge.rawValue,
                            alignment: .center
                        )
                        .foregroundColor(style.iconColor)
                }.overlay {
                    DatePicker(
                        "",
                        selection: $datePickerDate,
                        displayedComponents: [.date])
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .blendMode(.destinationOver)
                    .onTapGestureWorkaround {
                        selectedIndex = index
                    }
                    .onChange(of: datePickerDate, perform: { value in
                        date = value
                    })
                }
                .padding(.horizontal, NCConstants.Margins.medium.rawValue)
                .padding(.vertical, NCConstants.Margins.extraSmall.rawValue)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(
                        cornerRadius: 6
                    )
                    .strokeBorder(Color(.brandPrimary), lineWidth: index == selectedIndex ? 1 : 0)
                )
            }
            .padding(3)
            .overlay(
                RoundedRectangle(
                    cornerRadius: 9
                )
                .strokeBorder(Color(.inverseOutline02), lineWidth: index == selectedIndex ? 3 : 0)
            )
        }
    }
}

private struct OnTapGestureWorkaroundModifier: ViewModifier {
    let action: Action
    
    func body(content: Content) -> some View {
        if #available(iOS 17.1, *) {
            content
                .onTapGesture(count: 999, perform: {
                    // Overrides tap gesture to fix a bug starting on iOS 17.1 where
                    // using .onTapGesture prevents the calendar from showing
                    // https://stackoverflow.com/questions/77373659/swiftui-datepicker-issue-ios-17-1
                })
                .onTapGesture(perform: action)
        } else {
            content
                .onTapGesture(perform: action)
        }
    }
}

private extension View {
    func onTapGestureWorkaround(action: @escaping Action) -> some View {
        modifier(OnTapGestureWorkaroundModifier(action: action))
    }
}
