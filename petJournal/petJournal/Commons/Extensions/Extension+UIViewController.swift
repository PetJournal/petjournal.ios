//
//  Extension+UIViewController.swift
//  petJournal
//
//  Created by Marcylene Barreto on 28/03/23.
//

import UIKit

extension UIViewController {
    func showMessager(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
