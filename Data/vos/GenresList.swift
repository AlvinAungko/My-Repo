//
//  GenresList.swift
//  MovieViewImplemenatation
//
//  Created by Aung Ko Ko on 28/06/2021.
//

import Foundation

struct GenreStruct: Codable {
    let genres: [Genre]?
}

// MARK: - Genre
public struct Genre: Codable {
    public let id: Int?
    public let name: String?
    
    func convertToGenreVO() -> GenreVo{
        let voForGenre = GenreVo(name: name ?? "", isSelected: false, idForCell: id ?? 0)
        return voForGenre
    }
}
