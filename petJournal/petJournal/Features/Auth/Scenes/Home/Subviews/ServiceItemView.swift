//
//  ServiceItemView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 20/06/23.
//

import SwiftUI

struct ServiceItemView: View {
    enum TipoView: Int, CaseIterable {
        case viewA = 1
        case viewB = 2
        case viewC = 3
        case viewD = 4
    }
    
    let service: ServiceModel
    let action: () -> Void
    @State var tipoView: TipoView?
    
    var body: some View {
        Button {
            action()
            self.tipoView = .viewA
        } label: {
            VStack(alignment: .center, spacing: 9) {
                Image(service.image)
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(Color.theme.petWhite)
                    .frame(width: 80, height: 80)
                
                Text(service.name)
                    .foregroundColor(Color.theme.petWhite)
                    .font(.fedokaMedium(size: .medium))
                    .padding(10)
                    .lineLimit(2)
            }
            .frame(width: 162, height: 149)
            .background(service.color)
            .cornerRadius(8)
        }
    }
}
