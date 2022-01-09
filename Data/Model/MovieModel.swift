//
//  MovieModel.swift
//  MovieViewImplemenatation
//
//  Created by Aung Ko Ko on 30/07/2021.
//

import Foundation

protocol MovieModel
{
    func getSimilarMovies(dataToFetch:Int,completion:@escaping(MovieDBResponse<UpcomingMovie>)->Void)
    func getUpcomingMovie(completion:@escaping(MovieDBResponse<UpcomingMovie>)->Void)
    func getPopularMovie(completion:@escaping(MovieDBResponse<UpcomingMovie>)->Void)
    func fetchDetail(dataID:Int,completion:@escaping(MovieDBResponse<MovieDetailResponse>)->Void)
    func getCreditActorList(id:Int,completion:@escaping(MovieDBResponse<CreditActorList>)->Void)
    func getGenre(completion:@escaping(MovieDBResponse<GenreStruct>)->Void)
}

class MovieModelImplementation:BaseModel,MovieModel
{
   
    
   static let shared = MovieModelImplementation()
   private override init() {}
    
    func getGenre(completion: @escaping (MovieDBResponse<GenreStruct>) -> Void) {
        networkAgent.getGenre(completion: completion)
    }
    
    func getSimilarMovies(dataToFetch: Int, completion: @escaping (MovieDBResponse<UpcomingMovie>) -> Void) {
        networkAgent.getSimilarMovies(dataToFetch: dataToFetch, completion: completion)
    }
    
    func getUpcomingMovie(completion: @escaping (MovieDBResponse<UpcomingMovie>) -> Void) {
        networkAgent.getUpcomingMovie(completion: completion)
    }
    
    func getPopularMovie(completion: @escaping (MovieDBResponse<UpcomingMovie>) -> Void) {
        networkAgent.getPopularMovie(completion: completion)
    }
    
    func fetchDetail(dataID: Int, completion: @escaping (MovieDBResponse<MovieDetailResponse>) -> Void) {
        networkAgent.fetchDetail(dataID: dataID, completion: completion)
    }
    
    func getCreditActorList(id: Int, completion: @escaping (MovieDBResponse<CreditActorList>) -> Void) {
        networkAgent.getCreditActorList(id: id, completion: completion)
    }
}
