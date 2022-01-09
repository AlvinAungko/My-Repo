//
//  NetworkingProtocol.swift
//  MovieViewImplemenatation
//
//  Created by Aung Ko Ko on 28/07/2021.
//

import Foundation

protocol NetworkingProtocol
{
    
    //Trailers
    func getTrailerForSeries(seriesID:Int,completion:@escaping(MovieDBResponse<TrailerSeriesList>)->Void)
    func getTrailerVideos(movieID:Int,completion:@escaping(MovieDBResponse<TrailerMovieList>)->Void)
    
    func getSimilarSeries(id:Int,completion:@escaping(MovieDBResponse<PopularSeries>)->Void)
    
    func getSimilarMovies(dataToFetch:Int,completion:@escaping(MovieDBResponse<UpcomingMovie>)->Void)
    func getUpcomingMovie(completion:@escaping(MovieDBResponse<UpcomingMovie>)->Void)
    func getPopularMovie(completion:@escaping(MovieDBResponse<UpcomingMovie>)->Void)
    
    func getBestSeries(completion:@escaping(MovieDBResponse<PopularSeries>)->Void)
    func getGenre(completion:@escaping(MovieDBResponse<GenreStruct>)->Void)
    func fetchDetail(dataID:Int,completion:@escaping(MovieDBResponse<MovieDetailResponse>)->Void)
    func getTopRated(completion:@escaping(MovieDBResponse<PopularSeries>)->Void)
    func getPopularPeople(completion:@escaping(MovieDBResponse<PopularPeople>)->Void)
    func getMorePopularPeople(page:Int,completion:@escaping(MovieDBResponse<PopularPeople>)->Void)
    func getPopularPeopleDetail(id:Int,completion:@escaping(MovieDBResponse<PeopleDetailResponse>)->Void)
    func getCreditActorList(id:Int,completion:@escaping(MovieDBResponse<CreditActorList>)->Void)
    func getCredicActorForSeries(ID:Int,completion:@escaping(MovieDBResponse<CreditActorList>)->Void)
    func fetchDetailsForSeries(dataID:Int,completion:@escaping(MovieDBResponse<SeriesDetailResponse>)->Void)
    func fetchActorMovies(actorID:Int,completion:@escaping(MovieDBResponse<CastStarAt>)->Void)
    func fetchMovieListForUserSearch(page:Int,query:String,completion:@escaping(MovieDBResponse<PopularSeries>)->Void)
    func getMoreSeries(page:Int,completion:@escaping(MovieDBResponse<PopularSeries>)->Void)
}
