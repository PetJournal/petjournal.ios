//
//  Extension+UIFont.swift
//  petJournal
//
//  Created by Marcylene Barreto on 10/04/23.
//

import UIKit

extension UIFont {
    static func fredoka(_ font: FontType, fontSize: CGFloat) -> UIFont {
        let familyName = "Fredoka"
        guard let customFont = UIFont(name: "\(familyName)-\(font)", size: fontSize) else {
            fatalError("Failed to load font.")
        }
        return customFont
    }
}
