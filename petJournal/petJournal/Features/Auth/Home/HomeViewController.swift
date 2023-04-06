//
//  HomeViewController.swift
//  petJournal
//
//  Created by Marcylene Barreto on 24/03/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let textFieldPassword = PJTextField.fromXib()
    @IBOutlet weak var viewComponet: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .cyan
        setupViewTextFieldPassword()
        
    }


    private func setupViewTextFieldPassword() {
        viewComponet.addSubview(textFieldPassword)
        textFieldPassword.fillSuperView()
        textFieldPassword.setupTextField(type: .securityType, title: "Password", placeholder: "your placeholder")
//        textFieldPassword
    }

}
