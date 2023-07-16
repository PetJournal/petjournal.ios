//
//  BaseNavigationModel.swift
//  petJournal
//
//  Created by Marcylene Barreto on 11/07/23.
//

import SwiftUI

class BaseNavigationModel: ObservableObject {
    @Published var isPushActive: Bool = false
    @Published private(set) var mainView: AnyView?
    
    public func pushMain<Main: View>(view: Main) {
        isPushActive = false
        
        let container = PushContainer(content: view)
        self .mainView = AnyView(container)
        
        isPushActive = true
    }
}
