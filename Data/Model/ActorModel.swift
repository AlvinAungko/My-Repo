//
//  ActorModel.swift
//  MovieViewImplemenatation
//
//  Created by Aung Ko Ko on 30/07/2021.
//

import Foundation

protocol ActorModel {
    func getPopularPeople(completion:@escaping(MovieDBResponse<PopularPeople>)->Void)
    func getMorePopularPeople(page:Int,completion:@escaping(MovieDBResponse<PopularPeople>)->Void)
    func getPopularPeopleDetail(id:Int,completion:@escaping(MovieDBResponse<PeopleDetailResponse>)->Void)
    func fetchActorMovies(actorID:Int,completion:@escaping(MovieDBResponse<CastStarAt>)->Void)
}

class ActorModelImplementation:BaseModel,ActorModel
{
    static let shared = ActorModelImplementation()
    private override init() {}
    
    func getPopularPeople(completion: @escaping (MovieDBResponse<PopularPeople>) -> Void) {
        networkAgent.getPopularPeople(completion: completion)
    }
    
    func getMorePopularPeople(page: Int, completion: @escaping (MovieDBResponse<PopularPeople>) -> Void) {
        networkAgent.getMorePopularPeople(page: page, completion: completion)
    }
    
    func getPopularPeopleDetail(id: Int, completion: @escaping (MovieDBResponse<PeopleDetailResponse>) -> Void) {
        networkAgent.getPopularPeopleDetail(id: id, completion: completion)
    }
    
    func fetchActorMovies(actorID: Int, completion: @escaping (MovieDBResponse<CastStarAt>) -> Void) {
        networkAgent.fetchActorMovies(actorID: actorID, completion: completion)
    }
    
 
    
    
    
}
