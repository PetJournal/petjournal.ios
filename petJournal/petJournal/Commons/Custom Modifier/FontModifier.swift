//
//  FontModifier.swift
//  petJournal
//
//  Created by Marcylene Barreto on 13/05/23.
//

import SwiftUI

struct FontModifier: ViewModifier {
    var font: FontFamily = .fredoka
    var size: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.custom(font.rawValue, size: size))
    }
}
