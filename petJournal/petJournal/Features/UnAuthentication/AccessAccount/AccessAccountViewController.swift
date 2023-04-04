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
        
        // Error Description
        viewModel.textFieldsErrorMsg(baseTextFieldViewEmail.textFieldView.textPublisher,
                                     password: baseTextFieldViewPassword.textFieldView.textPublisher)
            .sink(receiveValue: { [weak self] in
                self?.errorMsg.text = $0.errorDescription
            })
            .store(in: &subscriptions)
        
        buttonLogin.tapPublisher.sink { [weak self] (_) in
            guard let self = self else { return }
            self.delegate?.viewController(self, didPerformAction: .accessAccount)
        }
        .store(in: &subscriptions)
    }
    
    private func setupViewTextFieldName() {
        viewTextFieldEmail.addSubview(baseTextFieldViewEmail)
        baseTextFieldViewEmail.fillSuperView()
        baseTextFieldViewEmail.setup(type: .defaultType, title: "Nome")
    }
    
    private func setupViewTextFieldPassword() {
        viewTextFieldPassword.addSubview(baseTextFieldViewPassword)
        baseTextFieldViewPassword.fillSuperView()
        baseTextFieldViewPassword.setup(type: .securityType, title: "Senha")
    }
    
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

