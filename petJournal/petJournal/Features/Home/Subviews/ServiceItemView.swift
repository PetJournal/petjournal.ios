//
//  ServiceItemView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 20/06/23.
//

import SwiftUI

struct ServiceItemView: View {
    let service: ServiceModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 9) {
            Image(service.image)
                .resizable()
                .scaledToFill()
                .foregroundColor(Color.theme.petWhite)
                .frame(width: 80, height: 80)
            
            Text(service.name)
                .foregroundColor(Color.theme.petWhite)
                .font(.subheadline)
                .padding(10)
                .lineLimit(2)
        }
        .frame(width: 162, height: 149)
        .background(service.color)
        .cornerRadius(8)
    }
}
