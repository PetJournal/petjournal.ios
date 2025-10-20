/// Creates a custom navigation bar with a back button and a title.
///
/// - Parameters:
///   - title: The title of the navigation bar.
///   - onClick: An action to be executed when the back button is pressed.
///
/// - Returns: A view that represents the custom navigation bar.

import SwiftUI

struct CustomNavigationBar: View {
    @EnvironmentObject private var router: NavigationRouter
    @Environment(\.dismiss) private var dismiss
    let title: String
    let onClick: (() -> Void)?
    
    var body: some View {
        HStack {
            Button {
                if let onClick = onClick {
                    onClick()
                } else {
                    // Check auth navigation first
                    if !router.authPath.isEmpty {
                        router.navigateBackAuth()
                    } else {
                        // Use current tab for navigation back
                        router.navigateBack(in: router.currentTab)
                    }
                }
            } label: {
                Image(systemName: "chevron.backward")
                    .foregroundStyle(Color(.petPrimary500))
            }
            Spacer()
            Text(title)
                .offset(x: -20.0)
            Spacer()
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
            .padding(.leading)
    }
}
