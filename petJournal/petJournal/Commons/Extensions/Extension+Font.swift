//
//  Extension+Font.swift
//  petJournal
//
//  Created by Giordano Mattiello on 20/10/23.
//

import SwiftUI

extension Font {
    static func fedokaMedium(size: Font.FontSize) -> Font {
        return Font.custom("Fredoka-Medium", size: size.rawValue)
    }
    static func fedokaLight(size: Font.FontSize) -> Font {
        return Font.custom( "Fredoka-Light", size: size.rawValue)
    }
    static func fedokaRegular(size: Font.FontSize) -> Font {
        return Font.custom( "Fredoka-Regular", size: size.rawValue)
    }
    static func fedokaSemiBold(size: Font.FontSize) -> Font {
        return Font.custom( "Fredoka-SemiBold", size: size.rawValue)
    }
    static func fedokaBold(size: Font.FontSize) -> Font {
        return Font.custom( "Fredoka-Bold", size: size.rawValue)
    }
    
    enum FontSize: CGFloat {
        case tiny = 12.0
        case small = 14.0
        case medium = 16.0
        case great = 18.0
        case large = 20.0
        case big = 22.0
        case biggest = 24.0
    }
}
