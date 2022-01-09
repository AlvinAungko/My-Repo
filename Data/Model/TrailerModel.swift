//
//  TrailerModel.swift
//  MovieViewImplemenatation
//
//  Created by Aung Ko Ko on 30/07/2021.
//

import Foundation

protocol  TrailerModel {
    func getTrailerForSeries(seriesID:Int,completion:@escaping(MovieDBResponse<TrailerSeriesList>)->Void)
    func getTrailerVideos(movieID:Int,completion:@escaping(MovieDBResponse<TrailerMovieList>)->Void)
}

class TrailerModelImplementation:BaseModel,TrailerModel
{
    static let shared = TrailerModelImplementation()
    private override init() {}
    
    func getTrailerForSeries(seriesID: Int, completion: @escaping (MovieDBResponse<TrailerSeriesList>) -> Void) {
        networkAgent.getTrailerForSeries(seriesID: seriesID, completion: completion)
    }
    
    func getTrailerVideos(movieID: Int, completion: @escaping (MovieDBResponse<TrailerMovieList>) -> Void) {
        networkAgent.getTrailerVideos(movieID: movieID, completion: completion)
    }
    
}
