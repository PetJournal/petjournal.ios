//
//  Extension+UIButton.swift
//  petJournal
//
//  Created by Marcylene Barreto on 04/04/23.
//

import UIKit
import Combine

extension UIButton {
    var tapPublisher: AnyPublisher<Void, Never> {
        ControlEvent(control: self, events: .touchUpInside).eraseToAnyPublisher()
    }
}
