//
//  SearchModel.swift
//  MovieViewImplemenatation
//
//  Created by Aung Ko Ko on 30/07/2021.
//

import Foundation

protocol SearchModel {
    func fetchMovieListForUserSearch(page:Int,query:String,completion:@escaping(MovieDBResponse<PopularSeries>)->Void)
}

class SearchModelImplementation:BaseModel,SearchModel
{
    static let shared = SearchModelImplementation()
    private override init() {}
    
    func fetchMovieListForUserSearch(page: Int, query: String, completion: @escaping (MovieDBResponse<PopularSeries>) -> Void) {
        networkAgent.fetchMovieListForUserSearch(page: page, query: query, completion: completion)
    }
    
}
