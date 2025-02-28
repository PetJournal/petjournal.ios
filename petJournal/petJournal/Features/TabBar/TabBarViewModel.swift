//
//  TabBarViewModel.swift
//  petJournal
//
//  Created by Marcylene Barreto on 20/06/23.
//

import SwiftUI

final class TabBarViewModel: ObservableObject {
    @Published var currentTab = 0

    init() {
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance.init(idiom: .unspecified)
    }
}
