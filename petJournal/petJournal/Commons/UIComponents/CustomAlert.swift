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
    var image: Image { get }
    var primaryButton: AnyView { get }
    var secondaryButton: AnyView? { get }
    var buttonDirection: Axis { get }
}

//MARK: - Struct
struct CustomAlertView: CustomAlertProtocol, View {
    
    @Binding var isPresented: Bool
    var image: Image
    var message: String
    var primaryButton: AnyView
    var secondaryButton: AnyView?
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
                
                image
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
struct CustomAlertPreview: View {
    //State variable to indicates when to show the alert
    @State private var showAlert = false
    @State private var secondAlert = false
    
    var body: some View {
        //Embed the button stack and the logic in a ZStack
        ZStack {
            VStack {
                PJButton.primary("Mostrar alerta") {
                    //Toogle the variable in your button
                    self.showAlert.toggle()
                }
                
                PJButton.primary("Segundo alerta") {
                    self.secondAlert.toggle()
                }
            }.padding()
            
            if showAlert {
                //Create the button when variable is toogled passing the args
                CustomAlertView(
                    isPresented: $showAlert,
                    image: Image(.imgCryingDog),
                    message: "Você realmente quer sair do app?",
                    primaryButton: AnyView(PJButton.secondary("Excluir") {
                        print("Botão EXCLUIR pressionado")
                    }),
                    secondaryButton: AnyView(PJButton.primary("Cancelar") {
                        print("Botão CANCELAR pressionado")
                        self.showAlert.toggle()
                    }),
                    buttonDirection: .horizontal)
            }
            
            if secondAlert {
                CustomAlertView(
                    isPresented: $secondAlert,
                    image: Image(.imgDogAndCat),
                    message: "Tarefa adicionada com sucesso!",
                    primaryButton: AnyView(PJButton.secondary("+ Nova tarefa") {
                        print("Botão EXCLUIR pressionado")
                    }),
                    secondaryButton: AnyView(PJButton.primary("Ir para a HomePage") {
                        print("Botão CANCELAR pressionado")
                        self.secondAlert.toggle()
                    }),
                    buttonDirection: .vertical)
            }
        }
    }
}

#Preview() {
    CustomAlertPreview()
}
