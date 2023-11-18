import SwiftUI

struct SideViewContent: View {
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        ZStack {
            VStack(alignment: .trailing) {
                SideMenuTopView()
                
                VStack {
                    Text("Side Menu")
                        .foregroundColor(Color.theme.petWhite)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity)
            .background(Color.theme.petPrimary)
        }
    }
    
    @ViewBuilder
    private func SideMenuTopView() -> some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    presentSideMenu.toggle()
                } label: {
                    Image(systemName: "x.mark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.theme.petWhite)
                }
                .frame(width: 30, height: 30)
            }
        }
        .frame(maxWidth: .infinity)
        .padding([.trailing, .top], 50)
        .padding(.bottom, 30)
    }
}
