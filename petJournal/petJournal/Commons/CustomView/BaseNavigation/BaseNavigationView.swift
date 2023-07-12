//
//  BaseNavigationView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 11/07/23.
//

import SwiftUI

struct BaseNavigationView<Content>: View where Content: View {
    @ObservedObject var model: BaseNavigationModel
    
    var content: () -> Content
    var body: some View {
        ZStack(alignment: .center) {
            self.content()
            if self .model.mainView != nil {
                NavigationLink(destination: self .model.mainView!, isActive: self .$model.isPushActive, label: {
                    EmptyView()
                })
                .isDetailLink( false )
            }
        }
    }
}
