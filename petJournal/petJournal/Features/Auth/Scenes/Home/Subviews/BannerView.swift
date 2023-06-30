//
//  BannerView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 20/06/23.
//

import SwiftUI

struct BannerView: View {
    let banner: HomeModel
    
    var body: some View {
        Image(banner.image)
            .resizable()
            .scaledToFit()
            .cornerRadius(12)
    }
}
