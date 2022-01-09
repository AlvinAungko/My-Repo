//
//  MovieItemDelegate.swift
//  MovieViewImplemenatation
//
//  Created by Aung Ko Ko on 01/06/2021.
//

import Foundation
 
protocol MovieItemDelegate {
    func onTapMovie(iDToBind:Int)
    func onTapSeries(idToBind:Int)
    func onTapPopularPeople(idToBind:Int)
    func onTapMoreActors(object:PopularPeople)
    func onTapMoreShowCase()
  
}
protocol GenreItemDelegate {
    func onTapMovieGenre(idToBind:Int)
}






