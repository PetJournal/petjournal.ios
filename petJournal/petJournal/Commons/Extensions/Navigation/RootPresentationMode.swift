//
//  RootPresentationMode.swift
//  petJournal
//
//  Created by Marcylene Barreto on 13/05/23.
//

import Foundation

typealias RootPresentationMode = Bool

extension RootPresentationMode {
    public mutating func dismiss() {
        self.toggle()
    }
}
