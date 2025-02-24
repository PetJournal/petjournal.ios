//
//  Extension+View.swift
//  petJournal
//
//  Created by Rafael Seron on 24/02/25.
//

import SwiftUI

extension View {
    func customNavigationBar(title: String, onClick: @escaping(() -> Void) = {}) -> some View {
        return HStack {
            Button {
                onClick()
            } label: {
                Image(systemName: "chevron.backward")
            }
            
            Text(title)

        }
    }
}

struct CustomNavigationBarPreview: View {
    var body: some View {
        customNavigationBar(title: "Editar dados do Pet")
    }
}

#Preview {
    CustomNavigationBarPreview()
}

