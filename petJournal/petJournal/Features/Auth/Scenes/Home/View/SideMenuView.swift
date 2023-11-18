import SwiftUI

struct SideMenuView<RenderView: View>: View {
    @Binding var isShowing: Bool
    var direction: Edge
    @ViewBuilder var content: RenderView
    
    var body: some View {
        ZStack(alignment: .trailing) {
            if isShowing {
                Color.theme.petBlack
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                content
                    .transition(.move(edge: direction))
                    .background(
                        Color.theme.petWhite
                    )
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
}
