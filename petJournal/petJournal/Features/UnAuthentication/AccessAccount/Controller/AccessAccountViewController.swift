//
//  AccessAccountViewController.swift
//  petJournal
//
//  Created by Marcylene Barreto on 14/04/23.
//

import UIKit
import SwiftUI

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
    @IBOutlet weak var viewComponent: UIView!
    @IBOutlet weak var createAccountComp: UIView!
    
    weak var delegate: AccessAccountDelegate?
    let viewModel = AccessAccountViewModel(service: AccessAccountService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        isEnableButton()
        setupViewTextFieldPassword()
        setupViewTextFieldEmail()
        setupViewComponent()
        setupComponentCreateAccount()
    }
    
    @IBAction func handleLoginButton(_ sender: UIButton) {
        guard let email = pjTextFieldEmail.textFieldInput.text, let password = pjTextFieldPassword.textFieldInput.text else { return }
        viewModel.authUser(email, pass: password)
        self.delegate?.viewController(HomeViewController(), didPerformAction: .accessAccount)

    }
            
    // MARK: - Setup Views in SwiftUI
    func setupViewComponent() {
        let actionUser = ActionsUser {
            self.delegate?.viewController(ForgotPasswordViewController(), didPerformAction: .forgotPassword)
        }
        let viewTest = UIHostingController(rootView: actionUser)
        let swiftuiView = viewTest.view!
        viewComponent.addSubview(swiftuiView)
        swiftuiView.fillSuperView()
    }
    
    func setupComponentCreateAccount() {
        let createAccount = CreateAccountComponent {
            self.delegate?.viewController(CreateAccountViewController(), didPerformAction: .createAccount)
        }
        let viewCreateAccount = UIHostingController(rootView: createAccount)
        let swiftuiView = viewCreateAccount.view!
        createAccountComp.addSubview(swiftuiView)
        swiftuiView.fillSuperView()
    }
    
    // MARK: - Setup TextField's
    private func setupViewTextFieldEmail() {
        pjTextFieldEmail.textFieldInput.tag = 0
        pjTextFieldEmail.textFieldInput.delegate = self
        textFieldEmail.addSubview(pjTextFieldEmail)
        pjTextFieldEmail.fillSuperView()
        pjTextFieldEmail.setupTextField(type: .defaultType, title: "Email", placeholder: "Your email")
        pjTextFieldEmail.updateTextField(state: .defaultState)
        pjTextFieldEmail.labelError.text = " "
    }
    
    private func setupViewTextFieldPassword() {
        pjTextFieldPassword.textFieldInput.tag = 1
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
            return "Usuário Incorreto"
        }
        return nil
    }
    
    func invalidPassword(_ value: String) -> String? {
        if !Validations().isValidPassword(value)  {
            return "Senha Incorreta"
        }
        return nil
    }
    
    func checkValidFields() {
        guard let mail = pjTextFieldEmail.textFieldInput.text else {return}
        guard let pass = pjTextFieldPassword.textFieldInput.text else {return}
        if !mail.isEmpty && !pass.isEmpty {
            if pjTextFieldEmail.labelError.isHidden && pjTextFieldPassword.labelError.isHidden {
                loginButton.isEnabled = true
            } else {
                loginButton.isEnabled = false
            }
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
