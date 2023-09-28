//
//  LoagingView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 26/09/23.
//

import SwiftUI

struct LoagingView: View {
    var body: some View {
        CustomGlassView(width: 200, height: 200, alignment: .center) {
            VStack {
                ProgressView("Aguarde")
                    .font(.footnote)
                    .padding()
            }
            .padding()
        }
    }
}

struct LoagingView_Previews: PreviewProvider {
    static var previews: some View {
        LoagingView()
    }
}
