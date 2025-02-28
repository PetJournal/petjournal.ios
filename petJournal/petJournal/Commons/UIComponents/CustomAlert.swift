//
//  CustomAlert.swift
//  petJournal
//
//  Created by Marcylene Barreto on 12/06/23.
//

import SwiftUI

struct CustomAlert: View {
    @Binding var show: Bool
    var titleAlert: String
    var descriptionAlert: String
    var buttonTitle: String
    var clicked: (() -> Void)
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            VStack(spacing: 25) {                
                Text(titleAlert)
                    .font(.title)
                    .foregroundColor(Color.theme.petPrimary)
                
                Text(descriptionAlert)
                    .foregroundColor(Color.theme.petPrimary)
                
                Button(action: clicked ) {
                    Text(buttonTitle)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 25)
                        .background(Color.theme.petPrimary)
                        .clipShape(Capsule())
                }
            }
            .padding(.vertical, 25)
            .padding(.horizontal, 30)
            .background(BlurView())
            .cornerRadius(25)
            
            Button(action: {
                withAnimation {
                    show.toggle()
                }
            }) {
                Image(systemName: "xmark.circle")
                    .font(.system(size: 15, weight: .light))
                    .foregroundColor(Color.theme.petGray800)
            }
            .padding()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.theme.petGray800.opacity(0.35)
        )
        .ignoresSafeArea()
    }
}
