//
//  HomeModel.swift
//  petJournal
//
//  Created by Marcylene Barreto on 20/06/23.
//

import Foundation

struct HomeModel: Codable, Identifiable {
    let id: Int
    let image: String
}

let mock_banners: [HomeModel] = [
    HomeModel(id: 1, image: "banner_01"),
    HomeModel(id: 2, image: "banner_02"),
    HomeModel(id: 3, image: "banner_03")
]
