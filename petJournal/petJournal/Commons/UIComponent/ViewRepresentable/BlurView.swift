//
//  BlurView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 12/06/23.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
        return view
    }
}
