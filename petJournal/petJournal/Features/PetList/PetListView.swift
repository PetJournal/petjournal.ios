import SwiftUI

struct PetListView: View {
    var body: some View {
        ZStack {
            Image("steps_background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .foregroundStyle(Color(red: 124, green: 84, blue: 167, opacity: 0.12))
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
