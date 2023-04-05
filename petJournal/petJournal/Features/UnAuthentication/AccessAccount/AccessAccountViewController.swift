//
//  AccessAccountViewController.swift
//  petJournal
//
//  Created by Marcylene Barreto on 25/03/23.
//

import UIKit
import Combine

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
    
    var showPassword: Bool = false
    private var authViewModel: AccessAccountViewModel = AccessAccountViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    private let baseTextFieldViewEmail = BaseTextField.fromXib()
    private let baseTextFieldViewPassword = BaseTextField.fromXib()
    
    weak var delegate: AccessAccountDelegate?
    
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var errorMsg: UILabel!
    @IBOutlet weak var viewTextFieldEmail: UIView!
    @IBOutlet weak var viewTextFieldPassword: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        buttonLogin.isHidden = true
        setupUI()
        bindingsEvent(authViewModel)
    }
    
    private func setupUI() {
        setupViewTextFieldName()
        setupViewTextFieldPassword()
    }
    
    func bindingsEvent(_ viewModel: AccessAccountViewModel) {
        viewModel.validFields(baseTextFieldViewEmail.textFieldView.textPublisher,
                              password: baseTextFieldViewPassword.textFieldView.textPublisher)
        .sink(receiveValue: { [weak self] in
            self?.buttonLogin.isHidden = $0
        })
        .store(in: &subscriptions)
        
        errorValidPassword(viewModel)
        errorValidEmail(viewModel)
        
        buttonLogin.tapPublisher.sink { [weak self] (_) in
            guard let self = self else { return }
            self.delegate?.viewController(self, didPerformAction: .accessAccount)
        }
        .store(in: &subscriptions)
    }
    
    // MARK: - Error's
    private func errorValidPassword(_ viewModel: AccessAccountViewModel) {
        viewModel.validPassword(baseTextFieldViewPassword.textFieldView.textPublisher)
            .sink { value in
                switch value {
                case true:
                    self.baseTextFieldViewPassword.update(state: .defaultState)
                    self.baseTextFieldViewPassword.labelError.text = ""
                case false:
                    self.baseTextFieldViewPassword.update(state: .errorState)
                    self.baseTextFieldViewPassword.labelError.text = "Senha invalida"
                }
            }
            .store(in: &subscriptions)
    }
    
    private func errorValidEmail(_ viewModel: AccessAccountViewModel) {
        viewModel.validEmail(baseTextFieldViewEmail.textFieldView.textPublisher)
            .sink { value in
                switch value {
                case true:
                    self.baseTextFieldViewEmail.labelError.text = ""
                    self.baseTextFieldViewEmail.update(state: .defaultState)
                case false:
                    self.baseTextFieldViewEmail.update(state: .errorState)
                    self.baseTextFieldViewEmail.labelError.text = "Usuario invalido"
                }
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - Setup TextField's
    private func setupViewTextFieldName() {
        viewTextFieldEmail.addSubview(baseTextFieldViewEmail)
        baseTextFieldViewEmail.fillSuperView()
        baseTextFieldViewEmail.setup(type: .defaultType, title: "Login")
    }
    
    private func setupViewTextFieldPassword() {
        viewTextFieldPassword.addSubview(baseTextFieldViewPassword)
        baseTextFieldViewPassword.fillSuperView()
        baseTextFieldViewPassword.setup(type: .securityType, title: "Senha")
    }
    
    // MARK: - Action
    @IBAction func forgotPassword(_ sender: UIButton) {
        self.delegate?.viewController(ForgotPasswordViewController(), didPerformAction: .forgotPassword)
    }
    
    @IBAction func rememberPassword(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
    @IBAction func buttonCreateAccount(_ sender: UIButton) {
        self.delegate?.viewController(CreateAccountViewController(), didPerformAction: .createAccount)
    }
}
