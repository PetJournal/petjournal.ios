import SwiftUI

struct PetListView: View {
    var body: some View {
        ZStack {
            Image(asset: .petListBackground)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .foregroundStyle(Color.theme.petPrimary100)
                .padding(.top, 80)
                .offset(y: -70)

            VStack {
                Text("Vamos ver qual pet?")
                    .font(.robotoSemiBold(size: .large))
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, 120)

                Spacer()
            }
        }
    }
}

#Preview {
    PetListView()
}
