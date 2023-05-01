//
//  AccessAccountViewController.swift
//  petJournal
//
//  Created by Marcylene Barreto on 14/04/23.
//

import UIKit

enum AccessAccountAction {
    case accessAccount
    case createAccount
    case forgotPassword
}

protocol AccessAccountDelegate: AnyObject {
    func viewController(_ viewController: UIViewController,
                        didPerformAction action: AccessAccountAction)
}

class AccessAccountViewController: UIViewController {
    
    private let pjTextFieldEmail = PJTextField.fromXib()
    private let pjTextFieldPassword = PJTextField.fromXib()
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var textFieldEmail: UIView!
    @IBOutlet weak var textFieldPassword: UIView!
    
    weak var delegate: AccessAccountDelegate?
    private let viewModel = AccessAccountViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        isEnableButton()
        bind()
        setupViewTextFieldPassword()
        setupViewTextFieldEmail()
    }
    
    func bind() {
        viewModel.error.binding { [weak self] err in
            if let error = err {
                print("\(error)")
            } else {
                self?.delegate?.viewController(HomeViewController(), didPerformAction: .accessAccount)
            }
        }
    }
    
    @IBAction func handleLoginButton(_ sender: UIButton) {
        guard let email = pjTextFieldEmail.textFieldInput.text, let password = pjTextFieldPassword.textFieldInput.text else { return }
        viewModel.authUser(email, pass: password)
        clearInputs()
    }
    
    @IBAction func forgotPassword(_ sender: UIButton) {
        self.delegate?.viewController(ForgotPasswordViewController(), didPerformAction: .forgotPassword)
    }
    
    @IBAction func handleCreateAccount(_ sender: UIButton) {
        self.delegate?.viewController(CreateAccountViewController(), didPerformAction: .createAccount)
    }
    
    @IBAction func rememberAccount(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
    func clearInputs() {
        loginButton.isEnabled = false
        pjTextFieldEmail.updateTextField(state: .defaultState)
        pjTextFieldPassword.updateTextField(state: .defaultState)
    }
    
    // MARK: - Setup TextField's
    private func setupViewTextFieldEmail() {
        pjTextFieldEmail.tag = 0
        pjTextFieldEmail.textFieldInput.delegate = self
        textFieldEmail.addSubview(pjTextFieldEmail)
        pjTextFieldEmail.fillSuperView()
        pjTextFieldEmail.setupTextField(type: .defaultType, title: "Email", placeholder: "Your email")
        pjTextFieldEmail.updateTextField(state: .defaultState)
        pjTextFieldEmail.labelError.text = " "
    }
    
    private func setupViewTextFieldPassword() {
        pjTextFieldPassword.tag = 1
        pjTextFieldPassword.textFieldInput.delegate = self
        textFieldPassword.addSubview(pjTextFieldPassword)
        pjTextFieldPassword.fillSuperView()
        pjTextFieldPassword.setupTextField(type: .securityType, title: "Password", placeholder: "Your password")
        pjTextFieldPassword.updateTextField(state: .defaultState)
        pjTextFieldPassword.labelError.text = " "
    }
    
    private func validTextFieldEmail(_ value: String) {
        if let error = invalidEmail(value) {
            pjTextFieldEmail.updateTextField(state: .errorState, errorMessage: error)
        } else {
            pjTextFieldEmail.updateTextField(state: .defaultState)
        }
        checkValidFields()
    }
    
    private func validTextFieldPassword(_ value: String) {
        if let error = invalidPassword(value) {
            pjTextFieldPassword.updateTextField(state: .errorState, errorMessage: error)
        } else {
            pjTextFieldPassword.updateTextField(state: .defaultState)
        }
        checkValidFields()
    }
    
    func invalidEmail(_ value: String) -> String? {
        if !Validations().validEmail(value) {
            return "Invalid Email"
        }
        return nil
    }
    
    func invalidPassword(_ value: String) -> String? {
        if value.count >= 8  {
            return "Invalid Quantity"
        }
        return nil
    }
    
    func checkValidFields() {
        if pjTextFieldEmail.labelError.isHidden && pjTextFieldPassword.labelError.isHidden {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
    }

    func isEnableButton() {
        loginButton.isEnabled = false
    }
}

extension AccessAccountViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField.tag {
        case 0:
            guard let email = textField.text else { return true }
            validTextFieldEmail(email)
            return true
        case 1:
            guard let password = textField.text else { return true }
            validTextFieldPassword(password)
            return true
        default:
            return true
        }
    }
}
