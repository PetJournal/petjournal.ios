//
//  ObservableObject.swift
//  petJournal
//
//  Created by Marcylene Barreto on 20/04/23.
//

import Foundation

final class ObservableObject<T> {
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func binding(_ listener: @escaping (T) -> Void) {
        listener(value)
        self.listener = listener
    }
}
