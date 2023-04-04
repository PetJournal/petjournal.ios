//
//  AccessAccountCordinator.swift
//  petJournal
//
//  Created by Marcylene Barreto on 31/03/23.
//

import Foundation
import UIKit

final class AccessAccountCordinator {
    // MARK: - Private Properties
    private let navigationController: UINavigationController?

    // MARK: - Intialization
    init(_ navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = AccessAccountViewController()
        viewController.delegate = self
        navigationController?.show(viewController, sender: self)
    }
}

extension AccessAccountCordinator: AccessAccountDelegate {
    func viewController(_ viewController: UIViewController,
                        didPerformAction action: AccessAccountAction) {
        switch action {
        case .accessAccount:
            navigationController?.show(HomeViewController(), sender: self)
        case .createAccount:
            navigationController?.show(CreateAccountViewController(), sender: self)
        case .forgotPassword:
            navigationController?.show(ForgotPasswordViewController(), sender: self)
        }
    }
}
