//
//  testeViewController.swift
//  petJournal
//
//  Created by Daiane Goncalves on 14/04/23.
//

import UIKit

class testeViewController: UIViewController {

    @IBOutlet var textFieldtest: UIView!
    
    private var test = PJTextField.fromXib()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testEmail()
    }

    func testEmail () {
        textFieldtest.addSubview(test)
        test.setupTextField(type: .securityType, title: "E-mail", placeholder: "Digite seu e-mail")
        test.fillSuperView()
    }

    
}
