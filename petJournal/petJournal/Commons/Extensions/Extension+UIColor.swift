//
//  Extension+UIColor.swift
//  petJournal
//
//  Created by Marcylene Barreto on 05/04/23.
//

import UIKit

extension UIColor {
    static let theme = ColorTheme()
}

struct ColorTheme {
    
    let petPrimary = UIColor(named: "petPrimary")
    let petSecondary = UIColor(named: "petSecondary")
    let petTertiary = UIColor(named: "petTertiary")
    let petCTA = UIColor(named: "petCTA")
    
    // MARK: - SystemColors
    let petSuccess = UIColor(named: "petSuccess")
    let petLink = UIColor(named: "petLink")
    let petError = UIColor(named: "petError")
    
    // MARK: - Black/White
    let petBlack = UIColor(named: "petBlack")
    let petWhite = UIColor(named: "petWhite")
    let petGray300 = UIColor(named: "petGray300")
    let petGray800 = UIColor(named: "petGray800")
}
