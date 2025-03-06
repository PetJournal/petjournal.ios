//
//  Extension+UIView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 12/04/23.
//

import SwiftUI

extension View {    
    func withDefaultTabBar(backgroundColor: Color = Color.theme.petPrimary,
                           selectItem: Color = Color.theme.petSecondary) -> some View {
        
        self.modifier(TabBarModifier(background: UIColor(backgroundColor),
                                     selectedItem: UIColor(selectItem)))
    }
}
