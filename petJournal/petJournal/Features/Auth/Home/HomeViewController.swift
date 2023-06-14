//
//  HomeViewController.swift
//  petJournal
//
//  Created by Marcylene Barreto on 24/03/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var labelTest: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelTest.font = .customFont(.fredoka, font: .regular, fontSize: 32)
        self.labelTest.text = "Welcome"
    }
    
    @IBAction func logoutButton(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
