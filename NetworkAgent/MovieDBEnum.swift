//
//  MovieDBEnum.swift
//  MovieViewImplemenatation
//
//  Created by Aung Ko Ko on 10/07/2021.
//

import Foundation
import Alamofire

enum MDBEndpont:URLConvertible{
    
    case trailerVideosForSeries(_seriesID: Int)
    case trailerVideosForMovies(_movieID : Int)
    case similarSeries(_seriesID:Int)
    case similarMovies(_movieID:Int)
    case upcomingMovie
    case popularMovie
    case bestSeries
    case genres
    case detailMovie(_movieID:Int)
    case topRated
    case popularPeople
    case morePopularPeople(_page:Int)
    case popularPeopleDetail(_personID:Int)
    case movieCreditActor(_movieID:Int)
    case seriesCreitActor(_seriesID:Int)
    case seriesDetail(_seriesID:Int)
    case moviesWhichActorsStarAt(_personID:Int)
    case searchMovieList(_page:Int,_query:String)
    case getMoreSeries(_page:Int)
    
    private var baseUrl:String{
        return Constants.urlServer
    }
    
    func asURL() throws -> URL {
       return url
    }
    
var url:URL{
        let urlComponent = NSURLComponents(string: baseUrl.appending(apiPath))
        if urlComponent?.queryItems == nil{
            urlComponent?.queryItems = []
        }
            urlComponent!.queryItems!.append(contentsOf: [URLQueryItem(name: "api_key", value: Constants.apiKey)])
           
        
        return urlComponent!.url!
    }
    
    private var apiPath:String{
     
        switch self{
        
        case.trailerVideosForSeries(let seriesID):return "/tv/\(seriesID)/videos"
        case.trailerVideosForMovies( let movieID):return "/movie/\(movieID)/videos"
        case.similarSeries(let seriesID):return "/tv/\(seriesID)/similar"
        case.similarMovies(let movieID):return "/movie/\(movieID)/similar"
        case.upcomingMovie:return "/movie/upcoming"
        case.popularMovie:return "/movie/popular"
        case.bestSeries:return "/tv/popular"
        case .genres:return "/genre/movie/list"
        case.detailMovie(let movieID):return "/movie/\(movieID)"
        case.topRated:return "/tv/top_rated"
        case.popularPeople:return "/person/popular"
        case.morePopularPeople(let page):return "/person/popular?page=\(page)"
        case.popularPeopleDetail(let personID):return "/person/\(personID)"
        case.movieCreditActor(let movieID):return "/movie/\(movieID)/credits"
        case.seriesCreitActor(let seriesID):return "/tv/\(seriesID)/credits"
        case.seriesDetail(let seriesID):return "/tv/\(seriesID)"
        case .moviesWhichActorsStarAt(let personID):return "/person/\(personID)/movie_credits"
        case.searchMovieList(let page, let query):return "/search/tv?&page=\(page)&query=\(query)"
        case.getMoreSeries(let page):return "/tv/popular?page=\(page)"
        
        }
    }
    
    
}
