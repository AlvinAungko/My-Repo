//
//  SeriesModel.swift
//  MovieViewImplemenatation
//
//  Created by Aung Ko Ko on 30/07/2021.
//

import Foundation

protocol SeriesModel {
    
    func getSimilarSeries(id:Int,completion:@escaping(MovieDBResponse<PopularSeries>)->Void)
    func getBestSeries(completion:@escaping(MovieDBResponse<PopularSeries>)->Void)
    func getTopRated(completion:@escaping(MovieDBResponse<PopularSeries>)->Void)
    func getCredicActorForSeries(ID:Int,completion:@escaping(MovieDBResponse<CreditActorList>)->Void)
    func fetchDetailsForSeries(dataID:Int,completion:@escaping(MovieDBResponse<SeriesDetailResponse>)->Void)
    func getMoreSeries(page:Int,completion:@escaping(MovieDBResponse<PopularSeries>)->Void)
    
}

class SeriesModelImplementation:BaseModel,SeriesModel
{
    static let shared = SeriesModelImplementation()
    
    private override init() {}
    
    func getSimilarSeries(id: Int, completion: @escaping (MovieDBResponse<PopularSeries>) -> Void) {
        networkAgent.getSimilarSeries(id: id, completion: completion)
    }
    
    func getBestSeries(completion: @escaping (MovieDBResponse<PopularSeries>) -> Void) {
        networkAgent.getBestSeries(completion: completion)
    }
    
    func getTopRated(completion: @escaping (MovieDBResponse<PopularSeries>) -> Void) {
        networkAgent.getTopRated(completion: completion)
    }
    
    func getCredicActorForSeries(ID: Int, completion: @escaping (MovieDBResponse<CreditActorList>) -> Void) {
        networkAgent.getCredicActorForSeries(ID: ID, completion: completion)
    }
    
    func fetchDetailsForSeries(dataID: Int, completion: @escaping (MovieDBResponse<SeriesDetailResponse>) -> Void) {
        networkAgent.fetchDetailsForSeries(dataID: dataID, completion: completion)
    }
    
    func getMoreSeries(page: Int, completion: @escaping (MovieDBResponse<PopularSeries>) -> Void) {
        networkAgent.getMoreSeries(page: page, completion: completion)
    }
    
    
}
