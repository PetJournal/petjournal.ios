//
//  Extension+UIColor.swift
//  petJournal
//
//  Created by Marcylene Barreto on 27/08/23.
//

import SwiftUI

extension UIColor {
    convenience init?(hex: String) {
        var chars = Array(hex.hasPrefix("#") ? hex.dropFirst() : hex[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
        case 6: chars.append(contentsOf: ["F","F"])
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                  green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                  blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                  alpha: .init(strtoul(String(chars[6...7]), nil, 16)) / 255)
    }
    
    
    convenience init(hexLightMode: String, hexDarkMode: String) {
        let color = Color(UIColor {
            ($0.userInterfaceStyle == .dark ? UIColor(hex: hexDarkMode) : UIColor(hex: hexLightMode)) ?? UIColor.clear
        })
        self.init(color)
    }
}

extension Color {
    init(hexLightMode: String, hexDarkMode: String) {
        self.init(UIColor(hexLightMode: hexLightMode, hexDarkMode: hexDarkMode))
    }
}
