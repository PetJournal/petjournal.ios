import SwiftUI

struct SideMenuView<RenderView: View>: View {
    @Binding var isShowing: Bool
    var direction: Edge
    @ViewBuilder var content: RenderView
    
    var body: some View {
        ZStack(alignment: .trailing) {
            if isShowing {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                content
                    .transition(.move(edge: direction))
                    .background(
                        Color.white
                    )
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
//    @State private var showMenu = false
//    @State private var showAlert = false
//    @StateObject var viewModel: AccessAccountViewModel
//
//     var edges = UIApplication.shared.windows.first?.safeAreaInsets
//     var menus = ["Profile", "Serviços", "Notificações", "Pets"]
//
//    var body: some View {
//        HStack(spacing: 0) {
//            Spacer()
//            VStack(alignment: .center) {
//                Image("pet_logoBlack")
//                    .resizable()
//                    .frame(width: 60, height: 60)
//                    .background(Color.theme.petWhite)
//                    .clipShape(Circle())
//
//                HStack(alignment: .top, spacing: 12) {
//                    VStack(alignment: .trailing, spacing: 12) {
//                        Text("Camila Queiroz")
//                            .font(.title3)
//                            .fontWeight(.bold)
//                            .foregroundColor(.black)
//
//                        Text("cmz@petjournal.com")
//                            .foregroundColor(.gray)
//                    }
//                }
//
//                Divider()
//                    .padding(.top)
//
//                VStack(alignment: .center) {
//                    ForEach(menus, id: \.self) { menu in
//                        MenuButton(title: menu)
//                    }
//                }
//
//                Divider()
//                    .padding(.top)
//
//                Button {
//                    showAlert = true
//                } label: {
//                    Text("Logout")
//                        .foregroundColor(Color.white)
//                }
//                .actionSheet(isPresented: $showAlert) {
//                    ActionSheet(title: Text("Deseja realmente sair?"), buttons: [
//                        .cancel(Text("Cancelar")) { },
//                        .destructive(Text("Sair")) {
//                            viewModel.logout()
//                        }
//                    ])
//                }
//
//                Spacer()
//
//            }
//            .padding(.horizontal, 20)
//            .padding(.top, edges!.top == 0 ? 15 : edges?.top)
//            .padding(.bottom, edges!.bottom == 0 ? 15 : edges?.bottom)
//            .frame(width: UIScreen.main.bounds.width - 115)
//            .background(Color.theme.petPrimary)
//            .ignoresSafeArea(.all, edges: .vertical)
//        }
//    }
//}
//
//struct MenuButton: View {
//    var title: String
//
//    var body: some View {
//        HStack(spacing: 15) {
//            Image(title)
//                .resizable()
//                .renderingMode(.template)
//                .frame(width: 24, height: 24)
//                .foregroundColor(.gray)
//
//            Text(title)
//                .foregroundColor(.gray)
//
//            Spacer(minLength: 0)
//        }
//        .padding(.vertical, 12)
//    }
}
