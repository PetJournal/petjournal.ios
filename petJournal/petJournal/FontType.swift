//
//  FontType.swift
//  petJournal
//
//  Created by Marcylene Barreto on 08/04/23.
//

import UIKit

private let familyName = "Fredoka"

enum FontType: String {
    case regular = "Regular"
    case bold = "Bold"
    case medium = "Medium"
    case semiBold = "SemiBold"
    case light = "Light"
    
    func size(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: fullFontName, size: size) {
            return font
        }
        fatalError("Font '\(fullFontName)' does not exist.")
    }
    
    fileprivate var fullFontName: String {
        return rawValue.isEmpty ? familyName : familyName + "-" + rawValue
    }
}
