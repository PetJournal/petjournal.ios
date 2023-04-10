//
//  HomeViewController.swift
//  petJournal
//
//  Created by Marcylene Barreto on 24/03/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    // TODO: how to use component
    private let textFieldPassword = PJTextField.fromXib()
    @IBOutlet weak var viewComponet: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setupViewTextFieldPassword()
    }

    private func setupViewTextFieldPassword() {
        viewComponet.addSubview(textFieldPassword)
        textFieldPassword.fillSuperView()
        textFieldPassword.setupTextField(type: .securityType, title: "Password", placeholder: "your placeholder")
    }
}
