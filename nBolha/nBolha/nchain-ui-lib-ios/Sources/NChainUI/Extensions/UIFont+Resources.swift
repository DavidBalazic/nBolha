//
//  UIFont+Resources.swift
//  
//
//  Created by Rok Črešnik on 11/08/2023.
//

import UIKit

extension UIFont {
    public static func registerFonts() {
        UIFont.registerFont(FontNameItalic)
        UIFont.registerFont(FontNameMedium)
        UIFont.registerFont(FontNameMediumItalic)
        UIFont.registerFont(FontNameRegular)
    }    
    
    public static func registerFont(_ name: String, bundle: Bundle = .nchainUI, fontExtension: String = "ttf") {
        var errorRef: Unmanaged<CFError>? = nil
        guard let font = getFont(named: name, bundle: bundle, fontExtension: fontExtension),
              CTFontManagerRegisterGraphicsFont(font, &errorRef) else {
            fatalError("Font \(name) not found")
        }
    }
    
    private static func getFont(named name: String, bundle: Bundle, fontExtension: String) -> CGFont? {
        let url = bundle.url(forResource: name, withExtension: fontExtension)
        guard let url = url,
              let data = NSData(contentsOf: url),
              let provider = CGDataProvider(data: data),
              let font = CGFont(provider)
        else { return nil }
        
        return font
    }
    
    public static var FontNameRegular = "IBMPlexSans-Regular"
    public static var FontNameMedium = "IBMPlexSans-Medium"
    public static var FontNameMediumItalic = "IBMPlexSans-MediumItalic"
    public static var FontNameItalic = "IBMPlexSans-Italic"
    
    public enum Size: CGFloat {
        case extraSmall = 10
        case small = 12
        case medium = 14
        case large = 16
        case extraLarge = 18
        case huge = 20
        case extraHuge = 24
        case enourmous = 28
        case extraEnourmous = 32
        case titan = 36
        case extraTitan = 40
    }
    
    public static let title01 = UIFont(name: FontNameMedium, size: Size.extraTitan.rawValue)!
    public static let title02 = UIFont(name: FontNameMedium, size: Size.titan.rawValue)!
    public static let title03 = UIFont(name: FontNameMedium, size: Size.extraEnourmous.rawValue)!
    public static let title04 = UIFont(name: FontNameMedium, size: Size.enourmous.rawValue)!
    public static let title05 = UIFont(name: FontNameMedium, size: Size.extraHuge.rawValue)!
    public static let title06 = UIFont(name: FontNameMedium, size: Size.huge.rawValue)!
    
    public static let subtitle01 = UIFont(name: FontNameMedium, size: Size.extraLarge.rawValue)!
    public static let subtitle02 = UIFont(name: FontNameMedium, size: Size.large.rawValue)!
    public static let subtitle03 = UIFont(name: FontNameMedium, size: Size.medium.rawValue)!
    public static let subtitle04 = UIFont(name: FontNameMediumItalic, size: Size.medium.rawValue)!
    
    public static let body01 = UIFont(name: FontNameRegular, size: Size.extraLarge.rawValue)!
    public static let body02 = UIFont(name: FontNameRegular, size: Size.large.rawValue)!
    public static let body03 = UIFont(name: FontNameRegular, size: Size.medium.rawValue)!
    public static let body04 = UIFont(name: FontNameItalic, size: Size.medium.rawValue)!
    
    public static let caption01 = UIFont(name: FontNameMedium, size: Size.small.rawValue)!
    public static let caption02 = UIFont(name: FontNameRegular, size: Size.extraSmall.rawValue)!
    public static let caption03 = UIFont(name: FontNameMedium, size: Size.extraSmall.rawValue)!
    
    public static let underline01 = UIFont(name: FontNameMedium, size: Size.large.rawValue)!
    public static let underline02 = UIFont(name: FontNameMedium, size: Size.medium.rawValue)!
    
    public static let overline = UIFont(name: FontNameRegular, size: Size.medium.rawValue)!
}
