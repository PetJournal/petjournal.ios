//
//  Extension+TextField.swift
//  petJournal
//
//  Created by Marcylene Barreto on 04/04/23.
//

import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String?, Never> {
        ControlPublisher(self,
                         controlEvents: [.allEditingEvents, .valueChanged],
                         keyPath: \.text)
            .eraseToAnyPublisher()
    }
}
