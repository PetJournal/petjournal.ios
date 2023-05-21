//
//  InputComponent.swift
//  petJournal
//
//  Created by Marcylene Barreto on 15/05/23.
//

import SwiftUI

struct InputComponent: View {
    @Binding var text: String
    var corners: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            TextField("", text: $text)
                .font(.title2)
                .multilineTextAlignment(.center)
        }
        .frame(width: 30, height: 60)
        .padding(10)
        .background(corners ? Color.theme.petWhite :  Color.theme.petGray300)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(corners ? Color.theme.petCTA : Color.theme.petCTA.opacity(0.5),
                        lineWidth: 2)
        )
    }
}
