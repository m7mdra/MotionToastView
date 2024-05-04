//
//  Fonts.swift
//  MotionToastView
//
//  Created by mega on 04/05/2024.
//

import Foundation

public class Fonts: NSObject {
    
    public enum Style: CaseIterable {
        case bold
        case regular
        case medium
        public var value: String {
            switch self {
            case .bold: return "Tajawal-Bold"
            case .regular: return "Tajawal-Regular"
            case .medium: return "Tajawal-Medium"
            }
        }
        public var font: UIFont {
            switch self{
            case .bold:
                return UIFont(name: self.value, size: 15)!
            case .medium:
                return UIFont(name: self.value, size: 13)!
            case .regular:
                return UIFont(name: self.value, size: 13)!
                
            }
        }
    }
    
    // Lazy var instead of method so it's only ever called once per app session.
    public static var loadFonts: () -> Void = {
        let fontNames = Style.allCases.map { $0.value }
        for fontName in fontNames {
            loadFont(withName: fontName)
        }
        return {}
    }()
    
    private static func loadFont(withName fontName: String) {

        guard
            let bundleURL = Bundle(for: self).url(forResource: "MotionToastView", withExtension: "bundle"),
            let bundle = Bundle(url: bundleURL),
            let fontURL = bundle.url(forResource: fontName, withExtension: "ttf"),
            let fontData = try? Data(contentsOf: fontURL) as CFData,
            let provider = CGDataProvider(data: fontData),
            let font = CGFont(provider) else { return }
        CTFontManagerRegisterGraphicsFont(font, nil)
    }
    
}
