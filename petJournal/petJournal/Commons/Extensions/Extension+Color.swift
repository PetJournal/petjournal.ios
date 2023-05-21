//
//  Extension+UIColor.swift
//  petJournal
//
//  Created by Marcylene Barreto on 05/04/23.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    
    let petPrimary = Color("petPrimary")
    let petSecondary = Color("petSecondary")
    let petTertiary = Color("petTertiary")
    let petCTA = Color("petCTA")
    
    // MARK: - SystemColors
    let petSuccess = Color("petSuccess")
    let petLink = Color("petLink")
    let petError = Color("petError")
    
    // MARK: - Black/White
    let petBlack = Color("petBlack")
    let petWhite = Color("petWhite")
    let petGray300 = Color("petGray300")
    let petGray800 = Color("petGray800")
}
