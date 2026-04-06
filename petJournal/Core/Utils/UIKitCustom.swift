//
//  UIKitCustom.swift
//  petJournal
//
//  Created by Marcylene Barreto on 27/08/23.
//

import SwiftUI

protocol UIKitCustomProtocol {
    static var primaryColor: Color { get }
}

class UIKitCustom: UIKitCustomProtocol {
    static var primaryColor = Color(hexLightMode: "#7C54A7", hexDarkMode: "#7C54A7")
    static var secondaryColor = Color(hexLightMode: "#AFD9DB", hexDarkMode: "#AFD9DB")
    static var petTertiary = Color(hexLightMode: "#FFB8EB", hexDarkMode: "#FFB8EB")
    static var petSuccess = Color(hexLightMode: "#50C24E", hexDarkMode: "#50C24E")
    static var petLink = Color(hexLightMode: "#54C1E9", hexDarkMode: "#54C1E9")
    static var petError = Color(hexLightMode: "#FF2222", hexDarkMode: "#FF2222")
    static var petCTA = Color(hexLightMode: "#8093F1", hexDarkMode: "#8093F1")
    static var petGray300 = Color(hexLightMode: "#F9F9F9", hexDarkMode: "#F9F9F9")
    static var petGray800 = Color(hexLightMode: "#8C8C8C", hexDarkMode: "#8C8C8C")
    static var petWhite = Color(hexLightMode: "#FFFFFF", hexDarkMode: "#FFFFFF")
    static var blackAndWhite = Color(hexLightMode: "#000000", hexDarkMode: "#FFFFFF")
}

extension UIKitCustom {
    static func lightFredoka(size: CGFloat) -> Font {
        return Font(UIFont(name: "Quicksand-Light", size: size) ?? UIFont.systemFont(ofSize: size))
    }
    
    static func regularFredoka(size: CGFloat) -> Font {
        return Font(UIFont(name: "Quicksand-Regular", size: size) ?? UIFont.systemFont(ofSize: size))
    }
    
    static func mediumFredoka(size: CGFloat) -> Font {
        return Font(UIFont(name: "Quicksand-Medium", size: size) ?? UIFont.systemFont(ofSize: size))
    }
    
    static func semiboldFredoka(size: CGFloat) -> Font {
        return Font(UIFont(name: "Quicksand-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size))
    }
    
    static func boldQuicksand(size: CGFloat) -> Font {
        return Font(UIFont(name: "Quicksand-Bold", size: size) ?? UIFont.systemFont(ofSize: size))
    }
}
