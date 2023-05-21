//
//  View+Extension.swift
//  petJournal
//
//  Created by Marcylene Barreto on 11/05/23.
//

import SwiftUI

extension View {    
    func customFont(font: FontFamily, size: CGFloat) -> some View {
        self.modifier(FontModifier(font: font, size: size))
    }
}
