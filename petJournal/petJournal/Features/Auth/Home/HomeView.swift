//
//  HomeView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 12/05/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = SessionVM()
    var body: some View {
        VStack {
            
            Text(vm.userEmail ?? "")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
