//
//  ServicesModel.swift
//  petJournal
//
//  Created by Marcylene Barreto on 20/06/23.
//

import SwiftUI

struct ServiceModel: Identifiable, Hashable {
    var id: Int
    var name: String
    var image: String
    let color: Color
}

let mock_services: [ServiceModel] = [
    ServiceModel(id: 1, name: "Agendar Vacina", image: "pets_calendar", color: Color.theme.petPrimary),
    ServiceModel(id: 2, name: "PetShops", image: "petshop", color: Color.theme.petCTA),
    ServiceModel(id: 3, name: "Registro de Vermifugos", image: "medical-drops", color: Color.theme.petSecondary),
    ServiceModel(id: 4, name: "Registro de Vacinas", image: "register_vacine", color: Color.theme.petTertiary),
    ServiceModel(id: 5, name: "Registro de Vermifugos", image: "medical-drops", color: Color.theme.petSecondary),
    ServiceModel(id: 6, name: "Registro de Vermifugos", image: "medical-drops", color: Color.theme.petSecondary),
    ServiceModel(id: 7, name: "Registro de Vermifugos", image: "medical-drops", color: Color.theme.petSecondary),
]
