//
//  WaitingCode.swift
//  petJournal
//
//  Created by Marcylene Barreto on 15/05/23.
//

import SwiftUI

struct WaitingCodeView: View {
    @StateObject var viewModel: WaitingViewModel = .init()
    @FocusState var activeField: FocusStateOTP?
    @State private var isEditPassword: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Image("pet_logoPrimary")
                    .resizable()
                    .frame(width: 148, height: 128)
                
                Spacer()
                
                VStack(spacing: 10) {
                    Text("Acabamos de enviar um código para seu e-mail")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                    
                    Text("Insira no campo abaixo o código de verificação de 6 dígitos enviado para o seu email.")
                        .font(.footnote)
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 10) {
                        getCodeReAuth()
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Reenviar Código?")
                            .font(.footnote)
                            .fontWeight(.light)
                    }
                }
                Spacer()
                
                PJButton(title: "Enviar", buttonType: .primaryType) {
                    self.isEditPassword = true
                }
                .disabled(viewModel.checkState())
                .opacity(viewModel.checkState() ? 0.3 : 1)
                editPassword
                
                Text("Dica: Caso não encontre o e-mail na sua caixa de entrada, verifique a pasta de Spam!")
                    .font(.footnote)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .onChange(of: viewModel.codeFields) { newValue in
                viewModel.checkValueField(value: newValue)
                nextField(value: newValue)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environment(\.rootPresentationMode, self.$isEditPassword)
        }
    }
}

// MARK: - View
extension WaitingCodeView {
    private var editPassword: some View {
        HStack {
            NavigationLink(
                destination: EditPasswordView(viewModel: EditPasswordViewModel()).navigationBarHidden(true),
                isActive: self.$isEditPassword) {EmptyView()}
                .isDetailLink(false)
                .navigationBarHidden(true)
        }
    }
}

// MARK: - Functions
extension WaitingCodeView {
    func nextField(value: [String]) {
        for index in 0..<5 {
            if value[index].count == 1 && viewModel.activeState(index: index) == activeField {
                activeField = viewModel.activeState(index: index + 1)
            }
        }
    }
    
    @ViewBuilder
    func getCodeReAuth() -> some View {
        HStack {
            ForEach(0..<6, id: \.self) { code in
                VStack(spacing: 8) {
                    InputComponent(text: $viewModel.codeFields[code], corners: activeField == viewModel.activeState(index: code))
                        .focused($activeField, equals: viewModel.activeState(index: code))
                }
            }
        }
    }
}
