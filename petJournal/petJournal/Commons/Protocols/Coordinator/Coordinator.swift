//
//  Coordinator.swift
//  petJournal
//
//  Created by Marcylene Barreto on 27/04/23.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController? { get set }
    
    func start()
}
