//
//  ForPopularPeople.swift
//  MovieViewImplemenatation
//
//  Created by Aung Ko Ko on 01/07/2021.
//

import Foundation

struct PopularPeople: Codable {
    public let page: Int?
    public let results: [PeopleDetail]?
   public let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct PeopleDetail:Codable{
    
    let profilePath:String?
    let adult:Bool?
    let gender:Int?
    let id:Int?
    let knownFor:[thisReasons]?
    let knownForDepartment:String?
    let name:String?
    let popularity:Double?
 
    
    enum CodingKeys:String,CodingKey{
        case profilePath = "profile_path"
        case adult,gender,id,name,popularity
        case knownForDepartment = "known_for_department"
        case knownFor = "known_for"
       
    }
    
}

struct thisReasons: Codable {
    
        let backdropPath: String?
        let firstAirDate: String?
        let genreIDS: [Int]?
        let id: Int?
        let mediaType: String?
        let name: String?
        let originCountry: [String]?
        let originalLanguage: String?
        let originalName, overview: String?
        let posterPath: String?
        let voteAverage: Double?
        let voteCount: Int?
        let adult: Bool?
        let originalTitle, releaseDate, title: String?
        let video: Bool?

    enum CodingKeys: String, CodingKey {
        
        case backdropPath = "backdrop_path"
               case firstAirDate = "first_air_date"
               case genreIDS = "genre_ids"
               case id
               case mediaType = "media_type"
               case name
               case originCountry = "origin_country"
               case originalLanguage = "original_language"
               case originalName = "original_name"
               case overview
               case posterPath = "poster_path"
               case voteAverage = "vote_average"
               case voteCount = "vote_count"
               case adult
               case originalTitle = "original_title"
               case releaseDate = "release_date"
               case title, video
    }
   
}


