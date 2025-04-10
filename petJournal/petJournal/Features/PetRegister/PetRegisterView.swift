//
//  PetRegisterView.swift
//  petJournal
//
//  Created by Rafael Seron on 24/02/25.
//

import SwiftUI

struct PetRegisterView: View {
    
    @StateObject private var viewModel = PetRegisterViewModel.shared
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            customNavigationBar(title: "Editar dados do Pet") {
                presentationMode.wrappedValue.dismiss()
            }
            
            ScrollView {
                VStack(spacing: 16) {
                    
                    petCardComponent()
                        .offset(x: 35)
                    
                    
                    Text("Nome do pet")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Nome do pet", text: $viewModel.petName)
                        .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                        .padding(.leading)
                        .padding(.vertical, 10)
                        .background(Color.secondary.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Text("Raça")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    AutoCompleteSelect(selectedItem: $viewModel.breedName, items: viewModel.getBreed(), placeholder: "Qual a raça?")
                    
                    Text("Porte")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    AutoCompleteSelect(selectedItem: $viewModel.breedName, items: viewModel.getBreed(), placeholder: "Qual o porte?")
                    
                    Text("Data de nascimento")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Data de nascimento", text: $viewModel.dateOfBirth)
                        .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                        .padding(.leading)
                        .padding(.vertical, 10)
                        .background(Color.secondary.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Text("Peso")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Peso", text: $viewModel.weight)
                        .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                        .padding(.leading)
                        .padding(.vertical, 10)
                        .background(Color.secondary.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Text("Tipo")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    AutoCompleteSelect(selectedItem: $viewModel.breedName, items: viewModel.getBreed(), placeholder: "Qual o tipo do animal?")
                    
                    Text("Sexo")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack{
                        Button(action: {
                            // Salvar os dados
                        }) {
                            Text("Macho")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(minWidth: 121.00, maxWidth: 121.00 ,minHeight: 40.00, maxHeight: 40.00)
                                .background(Color(.petPrimary500))
                                .cornerRadius(50)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Salvar os dados
                        }) {
                            Text("Fêmea")
                                .font(.headline)
                                .foregroundColor(Color(.petPrimary500))
                                .frame(minWidth: 121.00, maxWidth: 121.00 ,minHeight: 40.00, maxHeight: 40.00)
                                .background(Color(.white))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                                .cornerRadius(50)
                        }
                    }.padding(Edge.Set.horizontal)
                    
                    
                    
                    Text("Castrado")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack{
                        Button(action: {
                            // Salvar os dados
                        }) {
                            Text("Sim")
                                .font(.headline)
                                .foregroundColor(Color(.petPrimary500))
                                .frame(minWidth: 121.00, maxWidth: 121.00 ,minHeight: 40.00, maxHeight: 40.00)
                                .background(Color(.white))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                                .cornerRadius(50)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Salvar os dados
                        }) {
                            Text("Não")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(minWidth: 121.00, maxWidth: 121.00 ,minHeight: 40.00, maxHeight: 40.00)
                                .background(Color(.petPrimary500))
                                .cornerRadius(50)
                        }
                    }.padding(Edge.Set.horizontal)
                    
                    Spacer()
                    
                    //GenderSelection(selectedGender: $selectedGender)
                    //CastrationSelection(isCastrated: $isCastrated)
                    
                    Button(action: {
                        // Salvar os dados
                    }) {
                        Text("Salvar")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(minWidth: 121.00, maxWidth: 121.00 ,minHeight: 40.00, maxHeight: 40.00)
                            .background(Color(.petPrimary500))
                            .cornerRadius(50)
                    }
                    .padding(.top, 16)
                }
                .padding()
            }
        }
        .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
    }
}

// MARK: - Extensions

extension PetRegisterView {
    func petCardComponent() -> some View {
        return HStack {
            Image(uiImage: viewModel.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .task {
                    await viewModel.getImage()
                }
                .frame(minWidth: 150, maxWidth: 150, minHeight: 150, maxHeight: 153)
                .clipped()
                .cornerRadius(18.0)
                
            
            Button {
                //action
            } label: {
                VStack {
                    Image(.icPencil)
                        .foregroundStyle(Color.white)
                }
                .frame(minWidth: 30.0, minHeight: 30.0)
                .background(Color(.petPrimary500))
                .cornerRadius(12)
            }
            .offset(x: -50, y: +50)
            
            Button {
                //action
            } label: {
                Image("ic_trash")
            }.offset(x: 30, y: -50)
        }
    }
}

// MARK: - Previews

#Preview {
    PetRegisterView()
}
