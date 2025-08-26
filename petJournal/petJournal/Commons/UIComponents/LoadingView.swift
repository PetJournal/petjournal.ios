import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            // Fundo semi-transparente
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            
            // Conteúdo central
            CustomGlassView(width: 280, height: 280, alignment: .center) {
                VStack(spacing: 20) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                    
                    Text("Aguarde")
                        .font(.robotoSemiBold(size: .big))
                        .foregroundColor(Color.theme.petWhite)
                }
                .padding(30)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.clear)
    }
}

#Preview {
    LoadingView()
}
