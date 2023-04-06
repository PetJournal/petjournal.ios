//
//  HomeViewController.swift
//  petJournal
//
//  Created by Marcylene Barreto on 24/03/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let textFieldEmail = PJTextField.fromXib()
    @IBOutlet weak var viewComponet: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .cyan
        setupViewTextFieldPassword()
    }


    private func setupViewTextFieldPassword() {
        viewComponet.addSubview(textFieldEmail)
        textFieldEmail.fillSuperView()
        textFieldEmail.setupTextField(type: .securityType, title: "Password", placeholder: "your placeholder")
    }

}
