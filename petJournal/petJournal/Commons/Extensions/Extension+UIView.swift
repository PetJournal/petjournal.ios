//
//  Extension+UIView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 12/04/23.
//

import SwiftUI

extension View {    
    func withDefaultTabBar(backgroundColor: Color = Color.theme.petPrimary100,
                           selectItem: Color = Color.theme.petPrimary500) -> some View {
        
        self.modifier(TabBarModifier(background: UIColor(backgroundColor),
                                     selectedItem: UIColor(selectItem)))
    }
}
