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
    //Main
    let petPrimary100 = Color("petPrimary100")
    let petPrimary500 = Color("petPrimary500")
    let petSecondary100 = Color("petSecondary100")
    let petSecondary500 = Color("petSecondary500")
    //SystemColors
    let petSuccess100 = Color("petSuccess100")
    let petSuccess500 = Color("petSuccess500")
    let petError100 = Color("petError100")
    let petError500 = Color("petError500")
    let petWarning100 = Color("petWarning100")
    let petWarning500 = Color("petWarning500")
    //Black/White
    let petBackground = Color("petBackground")
    let petCards = Color("petCards")
    let petBlack = Color("petBlack")
    let petWhite = Color("petWhite")
    let petGray300 = Color("petGray300")
    let petGray800 = Color("petGray800")
    //Extra
    let petLightPink = Color("petLightPink")
    let petLightBlue = Color("petLightBlue")
    let petOrange = Color("petOrange")
    let petGreen = Color("petGreen")
}
