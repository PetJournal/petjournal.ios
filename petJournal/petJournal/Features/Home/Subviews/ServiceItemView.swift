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
        VStack(alignment: .center, spacing: 10) {
            Spacer()
            Image(service.image)
                .resizable()
                .scaledToFit()
                .foregroundColor(service.color)
                .frame(width: 80, height: 80)
            
            Text(service.name)
                .foregroundColor(service.color)
                .font(.footnote)
                .lineLimit(2)
            Spacer()
        }
        .frame(width: 150, height: 150)
        .background(Color.theme.petWhite)
        .cornerRadius(16)
        .shadow(radius: 10)
    }
}
