//
//  PJTextFieldView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 27/08/23.
//

import SwiftUI
import Combine

protocol PJTextFieldViewProtocol {
    var title: String { get }
    var error: String { get }
    var placeholder: String { get }
    var errorValidation: Bool { get }
    var textContentType: UITextContentType { get }
    func setKeyboardType() -> UIKeyboardType
}

struct PJTextFieldView: PJTextFieldViewProtocol, View {
    var error: String
    var errorValidation: Bool
    var title: String
    var placeholder: String
    var textContentType: UITextContentType
    var titleFont: Font = .fredokaMedium(size: .small)
    var placeHolderFont: Font = .fredokaMedium(size: .small)
    var validateFieldCallBack: (String) -> Bool
    
    @State var hasToShowErrorMessage: Bool = false
    @State private var isVisiblePassword: Bool = false
    @State private var isEditing: Bool = false
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    let emptyPlaceholder = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .foregroundColor(Color.theme.petPrimary500)
                .font(titleFont)
                .padding(.bottom, -3)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke((isFocused || text.count > 0) ? errorValidation ? Color.theme.petGray800 : Color.theme.petPrimary500 : Color.theme.petGray800, lineWidth: 1)
                    .frame(maxWidth: .infinity, maxHeight: 48)
                
                if text.isEmpty {
                    HStack {
                        Text(placeholder)
                            .foregroundColor(Color.theme.petGray300)
                            .font(placeHolderFont)
                        Spacer()
                    }
                    .padding(.leading, 16)
                }
                
                HStack {
                    if textContentType == .password {
                        if !isVisiblePassword {
                            SecureField(emptyPlaceholder, text: $text)
                                .focused($isFocused)
                                .onChange(of: isFocused, perform: { changed in
                                    if !changed {
                                        hasToShowErrorMessage = !validateFieldCallBack(text)
                                    }
                                    isFocused = changed
                                })
                                .font(placeHolderFont)
                                .foregroundStyle(Color.theme.petBlack)
                                .frame(height: 58)
                                .disableAutocorrection(true)
                                .textContentType(.password)
                                .keyboardType(setKeyboardType())
                                .autocapitalization(.none)
                        } else {
                            TextField(emptyPlaceholder, text: $text)
                                .focused($isFocused)
                                .onChange(of: isFocused, perform: { changed in
                                    if !changed {
                                        hasToShowErrorMessage = !validateFieldCallBack(text)
                                    }
                                    isFocused = changed
                                })
                                .font(placeHolderFont)
                                .foregroundStyle(Color.theme.petBlack)
                                .frame(height: 58)
                                .disableAutocorrection(true)
                                .textContentType(.password)
                                .keyboardType(setKeyboardType())
                                .autocapitalization(.none)
                        }
                        
                        Button {
                            isVisiblePassword.toggle()
                        } label: {
                            Image(asset: isVisiblePassword ? .openEye : .closeEye)
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.theme.petGray800)
                                .frame(width: 20, height: 20)
                        }
                        .padding(.horizontal, -3)
                    } else {
                        TextField(emptyPlaceholder, text: $text)
                            .focused($isFocused)
                            .onChange(of: isFocused, perform: { changed in
                                if !changed {
                                    hasToShowErrorMessage = !validateFieldCallBack(text)
                                }
                                isFocused = changed
                            })
                            .font(placeHolderFont)
                            .foregroundStyle(Color.theme.petBlack)
                            .frame(height: 58)
                            .disableAutocorrection(true)
                            .textContentType(textContentType)
                            .keyboardType(setKeyboardType())
                            .autocapitalization(.none)
                    }
                }
                .padding(.horizontal, 15)
            }
            if hasToShowErrorMessage {
                Text(error)
                    .foregroundColor(Color.theme.petError500)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

extension PJTextFieldView {
    func setKeyboardType() -> UIKeyboardType {
        switch textContentType {
        case .emailAddress: return .emailAddress
        case .telephoneNumber: return .phonePad
        default:
            return .default
        }
    }
}

struct PJTextFieldView_Previews: PreviewProvider {
    struct InteractivePreview: View {
        @State private var emailText = ""
        @State private var passwordText = ""
        @State private var phoneText = ""
        
        var body: some View {
            VStack(spacing: 20) {
                PJTextFieldView(
                    error: "Endereço de email inválido",
                    errorValidation: false,
                    title: "Email",
                    placeholder: "Digite seu email",
                    textContentType: .emailAddress,
                    validateFieldCallBack: { text in
                        // Simulação de validação
                        text.contains("@") && text.contains(".")
                    },
                    text: $emailText
                )
                
                PJTextFieldView(
                    error: "A senha precisa ter pelo menos 8 digitos",
                    errorValidation: passwordText.count < 8,
                    title: "Senha",
                    placeholder: "Digite sua senha",
                    textContentType: .password,
                    validateFieldCallBack: { text in
                        text.count >= 8
                    },
                    text: $passwordText
                )
                
                PJTextFieldView(
                    error: "Telefone inválido",
                    errorValidation: phoneText.count < 11,
                    title: "Telefone",
                    placeholder: "Digite seu telefone",
                    textContentType: .telephoneNumber,
                    validateFieldCallBack: { number in
                        number.count >= 11
                    },
                    text: $phoneText
                )
            }
            .padding()
        }
    }
    
    static var previews: some View {
        Group {
            InteractivePreview()
                .previewDisplayName("Light Mode")
                .padding()
        }
    }
}
