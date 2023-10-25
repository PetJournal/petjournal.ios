//
//  WaitingCodeView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 14/06/23.
//

import SwiftUI

struct WaitingCodeView: View {
    @StateObject private var viewModel: WaitingViewModel = .init()
    @FocusState private var activeField: FocusStateOTP?
    @State private var isEditPassword: Bool = false
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            VStack {
                Image("pet_logoPrimary")
                    .resizable()
                    .frame(width: 148, height: 128)
                
                Spacer()
                
                VStack(spacing: 10) {
                    Text("waitingcode-send-code")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                    
                    Text("waitingcode-insert")
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
                        showAlert.toggle()
                    } label: {
                        Text("waitingcode-resend-code")
                            .font(.footnote)
                            .fontWeight(.light)
                    }
                }
                
                Spacer()
                
                PJButton(title: "waitingcode-send".localized, buttonType: .primaryType) {
                    if viewModel.codeCheck {
                        isEditPassword = true
                    }
                }
                .disabled(viewModel.checkState())
                .opacity(viewModel.checkState() ? 0.3 : 1)
                editPassword
                
                Text("waitingcode-tip")
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
            .alert(isPresented: $viewModel.cancel) {
                Alert(title: Text("waitingcode-validation"),
                      message: Text("\(viewModel.checkCodeValidation)"),
                      primaryButton: .cancel(),
                      secondaryButton: .default(
                        Text("waitingcode-confirm"),
                        action: {
                            if viewModel.codeCheck {
                                self.isEditPassword = false
                            }
                        }
                      )
                )
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("waitingcode-reset"),
                  message: Text("waitingcode-resend"),
                  primaryButton: .cancel(),
                  secondaryButton: .default( Text("waitingcode-confirm") )
            )
        }
    }
}

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
                    CodeInput(text: $viewModel.codeFields[code], corners: activeField == viewModel.activeState(index: code))
                        .focused($activeField, equals: viewModel.activeState(index: code))
                }
            }
        }
    }
}
