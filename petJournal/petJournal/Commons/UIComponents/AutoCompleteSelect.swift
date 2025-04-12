//
//  AutoCompleteSelect.swift
//  petJournal
//
//  Created by Rafael Seron on 31/03/25.
//

import SwiftUI

/// Um componente de seleção com funcionalidade de autocompletar.
///
/// `AutoCompleteSelect` permite aos usuários escolher um item de uma lista de strings,
/// com suporte para filtragem à medida que o usuário digita. O componente exibe um campo de texto
/// para entrada do usuário e uma lista expansível de opções filtradas.
///
/// Exemplo de uso:
/// ```
/// @State private var selectedCity: String?
/// let cities = ["São Paulo", "Rio de Janeiro", "Belo Horizonte"]
///
/// var body: some View {
///     AutoCompleteSelect(
///         selectedItem: $selectedCity,
///         items: cities,
///         placeholder: "Selecione uma cidade"
///     )
/// }
/// ```
///
/// - Parameters:
///   - selectedItem: Um binding para a string selecionada pelo usuário.
///   - items: Um array de strings que serão exibidas como opções.
///   - placeholder: O texto de placeholder exibido no campo de texto quando vazio.
struct AutoCompleteSelect: View {
    @Binding var selectedItem: String?
    let items: [String]
    let placeholder: String
    @State private var searchText: String = ""
    @State private var isExpanded: Bool = false
    @State private var filteredItems: [String] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Campo de busca
            HStack {
                TextField(placeholder, text: $searchText)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 12)
                    .onChange(of: searchText) { newValue in
                        filterItems()
                        if !isExpanded {
                            isExpanded = true
                        }
                    }
                
                if let selected = selectedItem {
                    Text(selected)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Color.petPrimary500.opacity(0.2))
                        .cornerRadius(4)
                    
                    Button(action: {
                        selectedItem = nil
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
                
                Button(action: {
                    isExpanded.toggle()
                }) {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
            
            // Lista de opções
            if isExpanded {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 2) {
                        ForEach(filteredItems, id: \.self) { item in
                            Button(action: {
                                selectedItem = item
                                searchText = item
                                isExpanded = false
                            }) {
                                Text(item)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 12)
                                    .background(
                                        selectedItem == item ?
                                            Color.petPrimary500.opacity(0.1) :
                                            Color.clear
                                    )
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            if filteredItems.last != item {
                                Divider()
                                    .padding(.horizontal, 8)
                            }
                        }
                    }
                }
                .frame(height: min(CGFloat(filteredItems.count) * 44, 220))
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 4)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            }
        }
        .onAppear {
            filteredItems = items
        }
        .onTapGesture {
            // Fechar quando clicar fora do componente
            isExpanded = false
        }
    }
    
    private func filterItems() {
        if searchText.isEmpty {
            filteredItems = items
        } else {
            filteredItems = items.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }
}

// MARK: - Preview

struct AutoCompleteSelectDemoView: View {
    @State private var selectedItem: String?
    
    let items: [String] = [
        "Maçã",
        "Banana",
        "Laranja",
        "Abacaxi",
        "Morango",
        "Pêssego",
        "Uva",
        "Melancia",
        "Kiwi",
        "Manga"
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            AutoCompleteSelect(
                selectedItem: $selectedItem,
                items: items,
                placeholder: "Selecione uma fruta"
            )
            .padding()
            
            if let item = selectedItem {
                Text("Item selecionado: \(item)")
                    .padding()
            }
        }
        .padding()
    }
}

#Preview {
    AutoCompleteSelectDemoView()
}
