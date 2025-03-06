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
    ServiceModel(id: 1, name: "Vacinas",
                 image: ImageAsset.vaccine.rawValue,
                 color: Color.theme.petLink),
    ServiceModel(id: 2, name: "Consultas",
                 image: ImageAsset.vetAppointment.rawValue,
                 color: Color.theme.petSuccess),
    ServiceModel(id: 3, name: "Ração",
                 image: ImageAsset.dogFood.rawValue,
                 color: Color.theme.petError),
    ServiceModel(id: 4, name: "Medicamento",
                 image: ImageAsset.medicine.rawValue,
                 color: Color.theme.petCTA),
    ServiceModel(id: 5, name: "Banhos",
                 image: ImageAsset.shower.rawValue,
                 color: Color.theme.petTertiary),
    ServiceModel(id: 6, name: "Passeio",
                 image: ImageAsset.dogFace.rawValue,
                 color: Color.theme.petSecondary)
]
