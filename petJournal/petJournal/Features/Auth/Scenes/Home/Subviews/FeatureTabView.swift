//
//  FeatureTabView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 20/06/23.
//

import SwiftUI

struct FeatureTabView: View {
    @State private var currentIndex: Int = 0
    private let timerInterval: TimeInterval = 5
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(mock_banners.indices, id: \.self) { index in
                BannerView(banner: mock_banners[index])
                    .padding(.top, 10)
                    .padding(.horizontal, 15)
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .onReceive(timer) { _ in
            withAnimation {
                currentIndex = (currentIndex + 1) % mock_banners.count
            }
        }
    }
}
