//
//  ForSeries.swift
//  MovieViewImplemenatation
//
//  Created by Aung Ko Ko on 27/06/2021.
//

import Foundation

struct PopularSeries: Codable {
    let page: Int?
    let results: [Series]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Series: Codable {
    let backdropPath, firstAirDate: String?
    let genreIDS: [Int]?
    let id: Int?
    let name: String?
    let originCountry: [String]?
    let originalLanguage, originalName, overview: String?
    let popularity: Double?
    let posterPath: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIDS = "genre_ids"
        case id, name
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    func convertToResultObject()->Result{
        let voResult = Result(adult: false, backdropPath: self.backdropPath ?? "", genreIDS: self.genreIDS ?? [], id: self.id ?? 0, originalLanguage: self.originalLanguage ?? "", originalTitle: self.name ?? "Empty", overview: self.overview ?? "", popularity: self.popularity ?? 0.0, posterPath:self.posterPath ?? "", releaseDate: self.firstAirDate ?? "", title: self.name ?? "", video: false, voteAverage: self.voteAverage ?? 0.0, voteCount: self.voteCount ?? 0)
//        debugPrint(voResult.originalTitle ?? "Empty")
        return voResult
    }
}
