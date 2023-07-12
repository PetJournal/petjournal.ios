//
//  PushContainer.swift
//  petJournal
//
//  Created by Marcylene Barreto on 11/07/23.
//

import SwiftUI

struct PushContainer<Content: View> : View {
    let main: AnyView
    
    var body: some View {
        GeometryReader { proxy in
            self.generateBody(proxy: proxy)
        }
        .animation(.default)
    }
    
    init(content: Content) {
        self.main = AnyView.init(content)
    }
    
    func generateBody(proxy: GeometryProxy) -> some View {
        return ZStack {
            self.main
        }
    }
}
