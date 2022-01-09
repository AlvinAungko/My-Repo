//
//  DetailPeopleList.swift
//  MovieViewImplemenatation
//
//  Created by Aung Ko Ko on 04/07/2021.
//



// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let peopleDetailResponse = try? newJSONDecoder().decode(PeopleDetailResponse.self, from: jsonData)

import Foundation

// MARK: - PeopleDetailResponse
struct PeopleDetailResponse: Codable {
    let birthday, knownForDepartment: String?
//    let deathday: JSONNull?
    let id: Int?
    let name: String?
    let alsoKnownAs: [String]?
    let gender: Int?
    let biography: String?
    let popularity: Double?
    let placeOfBirth, profilePath: String?
    let adult: Bool?
    let imdbID: String?
//    let homepage: JSONNull?

    enum CodingKeys: String, CodingKey {
        case birthday
        case knownForDepartment = "known_for_department"
        case  id, name
        case alsoKnownAs = "also_known_as"
        case gender, biography, popularity
        case placeOfBirth = "place_of_birth"
        case profilePath = "profile_path"
        case adult
        case imdbID = "imdb_id"
//        case homepage
    }
}

// MARK: - Encode/decode helpers

//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
