//
//  Extension+Image.swift
//  petJournal
//
//  Created by Rafael Nunes on 28/02/25.
//

import SwiftUI

extension Image {
    // Initialize a image using its name from Asset Catalog
    init(asset: ImageAsset) {
        self.init(asset.rawValue)
    }
}
