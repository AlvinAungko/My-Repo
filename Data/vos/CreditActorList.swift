//
//  CreditActorList.swift
//  MovieViewImplemenatation
//
//  Created by Aung Ko Ko on 04/07/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let creditActorList = try? newJSONDecoder().decode(CreditActorList.self, from: jsonData)

import Foundation

// MARK: - CreditActorList
struct CreditActorList: Codable {
    let id: Int?
    let cast, crew: [Cast]?
}

// MARK: - Cast
struct Cast: Codable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment: String?
    let name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character, creditID: String?
    let order: Int?
    let department: String?
    let job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
    
    public func convertToPopularPeopleList() -> PeopleDetail {
        
        let peopleDetailObject = PeopleDetail(profilePath: self.profilePath ?? "", adult: self.adult ?? false, gender: self.gender ?? 0, id: self.id ?? 0, knownFor: nil, knownForDepartment: self.knownForDepartment ?? "", name: self.name ?? "", popularity: self.popularity ?? 0.0)
        return peopleDetailObject
        
    }
}

enum Department: String, Codable {
    case acting = "Acting"
    case art = "Art"
    case camera = "Camera"
    case costumeMakeUp = "Costume & Make-Up"
    case crew = "Crew"
    case directing = "Directing"
    case editing = "Editing"
    case lighting = "Lighting"
    case production = "Production"
    case sound = "Sound"
    case visualEffects = "Visual Effects"
    case writing = "Writing"
}


