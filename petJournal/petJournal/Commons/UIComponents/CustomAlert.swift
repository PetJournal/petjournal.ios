/// Creates a custom alert view with a message,
/// a image and up to two buttons with selected direction
///
///   - message: The message you want to show
///   - imageAsset: The image asset on the alert
///   - primaryButton: The button with a action of your choosing
///   - secondaryButton: A second option of action
///   - buttonDirection: The disposition wanted for the buttons
///

import SwiftUI

//MARK: - Protocol
protocol CustomAlertProtocol {
    var message: String { get }
    var imageAsset: ImageAsset { get }
    var primaryButton: PJButton { get }
    var secondaryButton: PJButton? { get }
    var buttonDirection: Axis { get }
}

//MARK: - Struct
struct CustomAlertView: CustomAlertProtocol, View {
    
    @Binding var isPresented: Bool
    var imageAsset: ImageAsset
    var message: String
    var primaryButton: PJButton
    var secondaryButton: PJButton?
    var buttonDirection: Axis
    
    var body: some View {
        ZStack {
            Color.theme.petBlack.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    self.isPresented.toggle()
                }
            
            VStack(spacing: 16) {
                Text(message)
                    .font(.robotoMedium(size: .large))
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                
                Image(asset: imageAsset)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                
                if buttonDirection == .horizontal {
                    HStack(spacing: 16) {
                        primaryButton
                        if secondaryButton != nil {
                            secondaryButton
                        }
                    }
                } else {
                    VStack() {
                        primaryButton
                        if secondaryButton != nil {
                            secondaryButton
                        }
                    }
                }
            }
            .padding(20)
            .background {
                if #available(iOS 17.0, *) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.theme.petWhite)
                        .stroke(Color.theme.petPrimary500, lineWidth: 3)
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.theme.petWhite)
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.theme.petPrimary500, lineWidth: 3)
                    }
                }
            }
            .cornerRadius(16)
            .shadow(radius: 10, x:5, y:5)
            .padding()
            .frame(maxWidth: 330)
        }
    }
}

//MARK: - Preview
struct ContentView: View {
    //State variable to indicates when to show the alert
    @State private var showAlert = false
    @State private var secondAlert = false
    
    var body: some View {
        //Embed the button stack and the logic in a ZStack
        ZStack {
            VStack {
                PJButton(title: "Mostrar alerta", buttonType: .primaryType) {
                    //Toogle the variable in your button
                    self.showAlert.toggle()
                }
                
                PJButton(title: "Segundo alerta", buttonType: .primaryType) {
                    self.secondAlert.toggle()
                }
            }.padding()
            
            if showAlert {
                //Create the button when variable is toogled passing the args
                CustomAlertView(
                    isPresented: $showAlert,
                    imageAsset: .cryingDog,
                    message: "Você realmente quer excluir o pet?",
                    primaryButton: PJButton(title: "Excluir", buttonType: .secundaryType, action: {
                        print("Botão EXCLUIR pressionado")
                    }),
                    secondaryButton: PJButton(title: "Cancelar", buttonType: .primaryType, action: {
                        print("Botão CANCELAR pressionado")
                        self.showAlert.toggle()
                    }),
                    buttonDirection: .horizontal)
            }
            
            if secondAlert {
                CustomAlertView(
                    isPresented: $secondAlert,
                    imageAsset: .cryingDog,
                    message: "Você realmente quer excluir o pet?",
                    primaryButton: PJButton(title: "Excluir", buttonType: .secundaryType, action: {
                        print("Botão EXCLUIR pressionado")
                    }),
                    secondaryButton: PJButton(title: "Cancelar", buttonType: .primaryType, action: {
                        print("Botão CANCELAR pressionado")
                        self.secondAlert.toggle()
                    }),
                    buttonDirection: .horizontal)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
