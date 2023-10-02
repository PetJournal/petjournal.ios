//
//  CustomGlassView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 26/09/23.
//

import SwiftUI

struct CustomGlassView<Content: View>: View {
    let content: Content
    let width: CGFloat
    let height: CGFloat
    let alignment: Alignment
    
    init(width: CGFloat, height: CGFloat, alignment: Alignment, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.width = width
        self.height = height
        self.alignment = alignment
    }
    
    var body: some View {
        ZStack {
            Color.white.opacity(0.35)
                .frame(width: width, height: height)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
            VStack {
                content
            }
            .padding()
            .foregroundColor(Color.black.opacity(0.8))
        }
        .frame(width: 300, alignment: alignment)
    }
}
