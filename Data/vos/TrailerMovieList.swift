//
//  TrailerMovieList.swift
//  MovieViewImplemenatation
//
//  Created by Aung Ko Ko on 06/07/2021.
//

import Foundation

// MARK: - TrailerMovieList
struct TrailerMovieList: Codable {
    let id: Int?
    let results: [TrailerItems]?
}

// MARK: - Result
struct TrailerItems: Codable {
    let id, iso639_1, iso3166_1, key: String?
    let name, site: String?
    let size: Int?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case key, name, site, size, type
    }
}

struct TrailerSeriesList:Codable{
    let id:Int?
    let results:[TrailerItems]?
}
