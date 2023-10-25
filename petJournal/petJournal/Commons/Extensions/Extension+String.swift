//
//  Extension+Swift.swift
//  petJournal
//
//  Created by Giordano Mattiello on 24/10/23.
//

import Foundation

extension String {
  var localized: String {
    return NSLocalizedString(self, comment: "Localizable")
  }
}
