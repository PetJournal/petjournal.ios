//
//  PJButton.swift
//  petJournal
//
//  Created by Marcylene Barreto on 16/05/23.
//

import SwiftUI

enum ButtonType {
    case primaryType
    case secundaryType
}

struct PJButton: View {
    @State var buttonType: ButtonType = .primaryType
    private let title: String
    private let action: () -> Void
    
    init(title: String,
         buttonType: ButtonType,
         action: @escaping () -> Void) {
        self.title = title
        self.action = action
        _buttonType = State(initialValue: buttonType)
    }
    
    var body: some View {
        HStack {
            Spacer()
            Button(action:self.action) {
                Text(self.title)
                    .frame(maxWidth:.infinity)
            }
            .buttonStyle(CustomButtonStyle(backgroundColor: buttonType == .primaryType ? Color.theme.petPrimary : Color.theme.petWhite,
                                           foregroundColor: buttonType == .primaryType ? Color.theme.petWhite : Color.theme.petPrimary))
            
            Spacer()
        }
        .frame(maxWidth:.infinity)
    }
}
