//
//  Extension+Font.swift
//  petJournal
//
//  Created by Giordano Mattiello on 20/10/23.
//

import SwiftUI

extension Font {
    
    //MARK: Fredoka font
    static func fredokaMedium(size: Font.FontSize) -> Font {
        return Font.custom("Fredoka-Medium", size: size.rawValue)
    }
    static func fredokaLight(size: Font.FontSize) -> Font {
        return Font.custom( "Fredoka-Light", size: size.rawValue)
    }
    static func fredokaRegular(size: Font.FontSize) -> Font {
        return Font.custom( "Fredoka-Regular", size: size.rawValue)
    }
    static func fredokaSemiBold(size: Font.FontSize) -> Font {
        return Font.custom( "Fredoka-SemiBold", size: size.rawValue)
    }
    static func fredokaBold(size: Font.FontSize) -> Font {
        return Font.custom( "Fredoka-Bold", size: size.rawValue)
    }
    
    //MARK: Roboto font
    static func robotoLight(size: Font.FontSize) -> Font {
        return Font.custom( "Roboto-Light", size: size.rawValue)
    }
    static func robotoMedium(size: Font.FontSize) -> Font {
        return Font.custom( "Roboto-Medium", size: size.rawValue)
    }
    static func robotoSemiBold(size: Font.FontSize) -> Font {
        return Font.custom( "Roboto-SemiBold", size: size.rawValue)
    }
    
    //MARK: Font size
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
