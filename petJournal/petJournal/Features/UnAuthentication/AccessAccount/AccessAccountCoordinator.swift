//
//  AccessAccountCoordinator.swift
//  petJournal
//
//  Created by Marcylene Barreto on 17/04/23.
//

import UIKit

class AccessAccountCordinator {
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

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var child: Coordinator? { get set }
    
    func start()
}
