//
//  PJTextField.swift
//  petJournal
//
//  Created by Marcylene Barreto on 06/04/23.
//

import UIKit

class PJTextField: UIView {

    // MARK: - Properties
    private let openEye = UIImage(named: "ic_openEye")
    private let closedEye = UIImage(named: "ic_closeEye")
    private let errorAlert = UIImage(named: "ic_error")
    private var isToggleImg = true
    private var errorValid: Bool = true
    
    // MARK: - Enums
    enum TextFieldType {
        case defaultType
        case securityType
    }
    
    enum TextFieldState {
        case defaultState
        case errorState
    }
    
    // MARK: - IBOutlet
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var viewTextField: UIView!
    @IBOutlet weak var textFieldInput: UITextField!
    @IBOutlet weak var imageToggled: UIImageView!
    @IBOutlet weak var viewActionToggled: UIView!
    
    // MARK: - Action
    @IBAction func handleButtonHide(_ sender: UIButton) {
        imageToggled.image = isToggleImg ? openEye : closedEye
        textFieldInput.isSecureTextEntry = !isToggleImg
        isToggleImg.toggle()
    }
    
    func setupTextField(type: TextFieldType, title: String, placeholder: String) {
        switch type {
        case .defaultType:
            setupDefaultType()
        case .securityType:
            setupSecurityType()
        }
        labelTitle.text = title
        labelError.textColor = UIColor.theme.petError
        labelError.font = UIFont.systemFont(ofSize: 13)
        textFieldInput.font = UIFont.systemFont(ofSize: 16)
        textFieldInput.placeholder = placeholder
        setupViewTextField(state: .defaultState)
        updateTextField(state: .defaultState)
    }
    
    func updateTextField(state: TextFieldState, errorMessage: String = " ") {
        switch state {
        case .defaultState:
            labelError.text = " "
            viewTextField.layer.borderColor = UIColor.theme.petGray800?.cgColor
        case .errorState:
            labelError.text = errorMessage
            viewTextField.layer.borderColor = UIColor.theme.petError?.cgColor
            imageToggled.image = errorValid ? errorAlert : closedEye
        }
    }
    
    private func setupDefaultType() {
        viewActionToggled.isHidden = true
        textFieldInput.isSecureTextEntry = false
    }
    
    private func setupSecurityType() {
        imageToggled.image = closedEye
        viewActionToggled.isHidden = false
        textFieldInput.isSecureTextEntry = true
    }
    
    private func setupViewTextField(state: TextFieldState) {
        viewTextField.layer.borderWidth = 1
        viewTextField.layer.cornerRadius = 5
    }

}
