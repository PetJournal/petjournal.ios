import SwiftUI

struct CustomTabBar: View {
    @ObservedObject var viewModel: TabBarViewModel
    
    var body: some View {
        ZStack {
            roundedBackground
            tabBar
        }
        .frame(maxWidth: .infinity, maxHeight: 70)
    }
    
    private var roundedBackground: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.theme.petPrimary100)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: -5)
            .edgesIgnoringSafeArea(.bottom)
    }
    
    private var tabBar: some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(0..<4, id: \.self) { index in
                Button(action: { viewModel.currentTab = index }) {
                    tabItem(
                        icon: icon(for: index),
                        title: title(for: index),
                        isSelected: viewModel.currentTab == index
                    )
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal, 20)
    }
    
    private func tabItem(icon: Image, title: String,
                         isSelected: Bool) -> some View {
        VStack(spacing: 4) {
            icon
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
            
            Text(title)
                .font(.robotoSemiBold(size: .great))
        }
        .foregroundColor(isSelected ? Color.theme.petPrimary500 : Color.theme.petGray800)
        .frame(maxWidth: .infinity)
    }
    
    private func icon(for index: Int) -> Image {
        switch index {
        case 0: return Image(.icHome)
        case 1: return Image(.petsCalendar)
        case 2: return Image(.icPaw)
        case 3: return Image(.icUser)
        default: return Image(.icPaw)
        }
    }
    
    private func title(for index: Int) -> String {
        switch index {
        case 0: return "Home"
        case 1: return "Agenda"
        case 2: return "Pets"
        case 3: return "Perfil"
        default: return ""
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(viewModel: TabBarViewModel())
    }
}
