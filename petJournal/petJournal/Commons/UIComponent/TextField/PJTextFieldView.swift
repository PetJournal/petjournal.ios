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
    
    @State private var isVisiblePassword: Bool = false
    @State private var isEditing: Bool = false
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .foregroundColor(Color.theme.petPrimary)
                .font(.system(size: 14))
                .padding(.bottom, -3)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke((isFocused || text.count > 0) ? errorValidation ? Color.theme.petGray800 : Color.theme.petPrimary : Color.theme.petGray800,
                            lineWidth: 1)
                
                HStack {
                    if textContentType == .password {
                        if !isVisiblePassword {
                            SecureField(placeholder, text: $text)
                                .focused($isFocused)
                                .onChange(of: isFocused, perform: { changed in
                                    isFocused = changed
                                })
                                .font(.system(size: 17))
                                .frame(height: 58)
                                .disableAutocorrection(true)
                                .textContentType(.password)
                                .keyboardType(setKeyboardType())
                                .autocapitalization(.none)
                        }
                        else {
                            TextField(placeholder, text: $text)
                                .focused($isFocused)
                                .onChange(of: isFocused, perform: { changed in
                                    isFocused = changed
                                })
                                .font(.system(size: 17))
                                .frame(height: 58)
                                .disableAutocorrection(true)
                                .textContentType(.password)
                                .keyboardType(setKeyboardType())
                                .autocapitalization(.none)
                        }
                        
                        Button {
                            isVisiblePassword.toggle()
                        } label: {
                            Image(isVisiblePassword ? "ic_openEye" : "ic_closeEye")
                                .resizable()
                                .foregroundColor(Color.theme.petGray800)
                                .frame(width: 20, height: 20)
                        }
                        .padding(.horizontal, -3)
                    }
                    else {
                        TextField(placeholder, text: $text)
                            .focused($isFocused)
                            .onChange(of: isFocused, perform: { changed in
                                isFocused = changed
                            })
                            .font(.system(size: 17))
                            .frame(height: 58)
                            .disableAutocorrection(true)
                            .textContentType(textContentType)
                            .keyboardType(setKeyboardType())
                            .autocapitalization(.none)
                    }
                }
                .padding(.horizontal, 15)
            }
            
            Text(error)
                .foregroundColor(Color.theme.petError)
                .fixedSize(horizontal: false, vertical: true)
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, maxHeight: 70)
        .padding(.vertical, 12)
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
