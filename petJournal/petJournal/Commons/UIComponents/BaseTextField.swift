//
//  BaseTextField.swift
//  petJournal
//
//  Created by Marcylene Barreto on 03/04/23.
//

import UIKit
import Combine

class BaseTextField: UIView {
    private let openEye = UIImage(named: "open_eye")
    private let closedEye = UIImage(named: "close_eye")
    private var isTogleEye = true
    
    enum TextFieldType {
        case defaultType
        case securityType
    }
    
    enum TextFieldState {
        case defaultState
        case errorState
    }

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var viewTextField: UIView!
    @IBOutlet weak var textFieldView: UITextField!
    @IBOutlet weak var imageRight: UIImageView!
    @IBOutlet weak var viewRightButton: UIView!
    
    // MARK: - Action
    @IBAction func buttonPassword(_ sender: UIButton) {
        imageRight.image = isTogleEye ? openEye : closedEye
        textFieldView.isSecureTextEntry = !isTogleEye
        isTogleEye.toggle()
    }
    
    func setup(type: TextFieldType, title: String) {
        switch type {
        case .defaultType:
            setupDefaultType()
        case .securityType:
            setupSecurityType()
        }
        labelTitle.text = title
        labelError.textColor = .red
        labelError.font = UIFont.systemFont(ofSize: 12)
        setupViewTextField(state: .defaultState)
        update(state: .defaultState)
    }
    
    func update(state: TextFieldState, errorMessage: String = " ") {
        switch state {
        case .defaultState:
            labelError.text = " "
            viewTextField.layer.borderColor = UIColor.gray.cgColor
        case .errorState:
            labelError.text = errorMessage
            viewTextField.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    private func setupDefaultType() {
        viewRightButton.isHidden = true
        textFieldView.isSecureTextEntry = false
    }
    
    private func setupSecurityType() {
        imageRight.image = closedEye
        viewRightButton.isHidden = false
        textFieldView.isSecureTextEntry = true
    }
    
    private func setupViewTextField(state: TextFieldState) {
        viewTextField.layer.borderWidth = 1
        viewTextField.layer.cornerRadius = 4
    }
}
