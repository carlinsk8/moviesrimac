//
//  MovieDataModel.swift
//  MoviesRimac
//
//  Created by Carlos on 22/04/25.
//

import Foundation

struct MovieDataModel: Codable {
    let results: [DataMovie]
}

struct DataMovie: Codable, Identifiable {
    let backdrop_path: String?
    let id: Int?
    let original_title: String?
    let overview: String?
    let original_language: String?
    let title: String?
    let release_date: String?
    let poster_path: String?
    let vote_average: Double?
}

struct MockData {
    static let movie = DataMovie(backdrop_path: "/vQ5T84t8h4N2xAswNFW9fkVIyZq.jpg", id: 536437, original_title: "Hypnotic", overview: "Un detective se ve envuelto en un misterio en el que está involucrada su hija desaparecida y un programa secreto del gobierno mientras investiga una serie de atracos de alto nivel.", original_language: "en", title: nil, release_date: "2023-05-11", poster_path: "/3IhGkkalwXguTlceGSl8XUJZOVI.jpg", vote_average: 6.8)
    static let idTrailer = "uI5rezDfDqI"
}
