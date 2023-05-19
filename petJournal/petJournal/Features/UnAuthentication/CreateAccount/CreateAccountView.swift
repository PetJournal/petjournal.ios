//
//  CreateAccountView.swift
//  petJournal
//
//  Created by Daiane Goncalves on 16/05/23.
//

import SwiftUI

struct CreateAccountView: View {
    
    @StateObject var viewModel: CreateAccountViewModel = .init()
    
    
    @State var email: String = ""
    
    var body: some View {
        VStack{
            Image("pet_logoWhite")
                .resizable()
                .frame(width: 130, height: 130)
                Text("Whatchatcha")
                .font(.system(size: 25))
                TextField("Placeholder", text: $email)
            Button(action: {}) {
                Text("Cadastrar")
                    .foregroundColor(.green)
                    .frame(width: 100, height: 70)
                    .background(Color.red)
                    .cornerRadius(20)
                    
            }
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
