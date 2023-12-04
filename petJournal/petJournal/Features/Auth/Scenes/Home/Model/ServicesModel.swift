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
    ServiceModel(id: 0, name: "Agenda", image: "pets_calendar", color: Color.theme.petCTA),
    ServiceModel(id: 1, name: "Localizar Serviços", image: "search_service", color: Color.theme.petPrimary),
    ServiceModel(id: 2, name: "Registro de Vacinas", image: "medical-drops", color: Color.theme.petSecondary),
    ServiceModel(id: 3, name: "Registro de Vermifugos", image: "register_vacine", color: Color.theme.petTertiary),
]
