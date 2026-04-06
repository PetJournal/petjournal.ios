//
//  Extension+UIFont.swift
//  petJournal
//
//  Created by Marcylene Barreto on 10/04/23.
//

import UIKit

extension UIFont {
    static func customFont(_ fontFamily: FontFamily, font: FontType, fontSize: CGFloat) -> UIFont {
        guard let myFont = UIFont(name: "\(fontFamily)-\(font)", size: fontSize) else {
            return UIFont.systemFont(ofSize: fontSize)
        }
        return myFont
    }
}
