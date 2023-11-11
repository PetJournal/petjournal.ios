//
//  HomeViewModel.swift
//  petJournal
//
//  Created by Marcylene Barreto on 10/11/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var userData: UserModel
    
    init(userData: UserModel) {
        self.userData = userData
    }
}
