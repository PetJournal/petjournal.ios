//
//  Extension+UIView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 12/04/23.
//

import SwiftUI

extension View {    
    func withDefaultTabBar(backgroundColor: Color, selectItem: Color) -> some View {
        self.modifier(TabBarModifier(background: UIColor(backgroundColor), selectedItem: UIColor(selectItem)))
    }
    
    func navigationBarColor(backgroundColor: Color, titleColor: Color?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: UIColor(titleColor ?? Color.clear)))
    }
}
