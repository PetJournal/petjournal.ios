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
    
    private var textFieldInput = BaseTextField.fromXib()
    
    weak var delegate: AccessAccountDelegate?
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var errorMsg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonLogin.isHidden = true
        bindingsEvent(authViewModel)
    }
    
    func bindingsEvent(_ viewModel: AccessAccountViewModel) {
        viewModel.validFields(textFieldEmail.textPublisher,
                              password: textFieldPassword.textPublisher)
        .sink(receiveValue: { [weak self] in
            self?.buttonLogin.isHidden = $0
        })
        .store(in: &subscriptions)
        
        // Error Description
        viewModel.textFieldsErrorMsg(textFieldEmail.textPublisher, password: textFieldPassword.textPublisher)
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

