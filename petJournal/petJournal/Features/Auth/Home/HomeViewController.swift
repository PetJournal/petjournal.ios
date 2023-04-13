//
//  HomeViewController.swift
//  petJournal
//
//  Created by Marcylene Barreto on 24/03/23.
//

import UIKit

class HomeViewController: UIViewController {

    private var textFieldPassword = PJTextField.fromXib()
    private var textFieldEmail = PJTextField.fromXib()
    
    @IBOutlet weak var labelTest: UILabel!
    @IBOutlet weak var testTextField: UIView!
    @IBOutlet weak var test2TextField: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.theme.petGray300
        self.labelTest.font = .customFont(.fredoka, font: .regular, fontSize: 32)
        setupViewTextFieldEmail()
        setupViewTextFieldPassword()
    }
    
    private func setupViewTextFieldEmail() {
        testTextField.addSubview(textFieldEmail)
        textFieldEmail.fillSuperView()
        textFieldEmail.setupTextField(type: .defaultType, title: "Email", placeholder: "Your placeholder")
    }
    
    private func setupViewTextFieldPassword() {
        test2TextField.addSubview(textFieldPassword)
        textFieldPassword.fillSuperView()
        textFieldPassword.setupTextField(type: .securityType, title: "Password", placeholder: "Your placeholder")
    }
}
