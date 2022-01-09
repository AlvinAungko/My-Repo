//
//  MovieNetworkagent.swift
//  MovieViewImplemenatation
//
//  Created by Aung Ko Ko on 26/06/2021.
//

import Foundation
import Alamofire

struct MovieNetworkAgent:NetworkingProtocol{
    
    static let shared = MovieNetworkAgent()
    
   private init(){}
    
    func getTrailerForSeries(seriesID:Int,completion:@escaping(MovieDBResponse<TrailerSeriesList>)->Void){
        
        AF.request(MDBEndpont.trailerVideosForSeries(_seriesID: seriesID)).responseDecodable(of: TrailerSeriesList.self) {
            switch $0.result{
            case.success(let trailerSeriesList):completion(.success(trailerSeriesList))
            case.failure(let errorFromServer):completion(.failure(HandleError($0, errorFromServer, MDBCommonErrorResponse.self)))
            }
        }
    }
    
    func getTrailerVideos(movieID:Int,completion:@escaping(MovieDBResponse<TrailerMovieList>)->Void){
        
        AF.request(MDBEndpont.trailerVideosForMovies(_movieID: movieID)).responseDecodable(of: TrailerMovieList.self) {
            switch $0.result{
            case.success(let trailerMovieList):completion(.success(trailerMovieList))
            case.failure(let errorFromServer):completion(.failure(HandleError($0, errorFromServer, MDBCommonErrorResponse.self)))
            }
        }
    }
    
    func getSimilarSeries(id:Int,completion:@escaping(MovieDBResponse<PopularSeries>)->Void){
        
        AF.request(MDBEndpont.similarSeries(_seriesID: id)).responseDecodable(of: PopularSeries.self) {
            switch $0.result{
            case .success(let popularSeriesData):completion(.success(popularSeriesData))
            case.failure(let errorFromServer):completion(.failure(HandleError($0, errorFromServer, MDBCommonErrorResponse.self)))
            }
        }
    }
    
    func getSimilarMovies(dataToFetch:Int,completion:@escaping(MovieDBResponse<UpcomingMovie>)->Void){

        AF.request(MDBEndpont.similarMovies(_movieID: dataToFetch)).responseDecodable(of: UpcomingMovie.self,  completionHandler: {
            switch $0.result{
            case.success(let upComingMovie):completion(.success(upComingMovie))
            case.failure(let Error):completion(.failure(HandleError($0, Error, MDBCommonErrorResponse.self)))
            }
        })
    }
    
    func getUpcomingMovie(completion:@escaping(MovieDBResponse<UpcomingMovie>)->Void){
        
        AF.request(MDBEndpont.upcomingMovie).responseDecodable(of: UpcomingMovie.self,  completionHandler: {
            switch $0.result{
            case.success(let upComingMovie): completion(.success(upComingMovie))
            case.failure(let Error):completion(.failure(HandleError($0, Error, MDBCommonErrorResponse.self)))
            }
        })

    }
    
    func getPopularMovie(completion:@escaping(MovieDBResponse<UpcomingMovie>)->Void){
        
        AF.request(MDBEndpont.popularMovie).responseDecodable(of: UpcomingMovie.self,  completionHandler: {
            switch $0.result{
            case .success(let upComingMovie):completion(.success(upComingMovie))
            case .failure(let errorFromServer):completion(.failure(HandleError($0, errorFromServer, MDBCommonErrorResponse.self)))
            }
        })
    }
    
    func getBestSeries(completion:@escaping(MovieDBResponse<PopularSeries>)->Void){
        
        AF.request(MDBEndpont.bestSeries).responseDecodable(of: PopularSeries.self,  completionHandler: {
            switch $0.result{
            case .success(let popularSeries):completion(.success(popularSeries))
            case .failure(let errorFromServer):completion(.failure(HandleError($0, errorFromServer, MDBCommonErrorResponse.self)))
                
            }
        })
       
    }
    func getGenre(completion:@escaping(MovieDBResponse<GenreStruct>)->Void){

        AF.request(MDBEndpont.genres).responseDecodable(of: GenreStruct.self, completionHandler: {
            switch $0.result{
            case .success(let genreStructObject):completion(.success(genreStructObject))
            case .failure(let errorFromServer):completion(.failure(HandleError($0, errorFromServer, MDBCommonErrorResponse.self)))
            }
        })
    }
    
    func fetchDetail(dataID:Int,completion:@escaping(MovieDBResponse<MovieDetailResponse>)->Void){

        AF.request(MDBEndpont.detailMovie(_movieID: dataID)).responseDecodable(of: MovieDetailResponse.self) {
            switch $0.result{
            case .success(let movieDetailListResponse):completion(.success(movieDetailListResponse))
            case . failure(let errorFromServer):completion(.failure(HandleError($0, errorFromServer, MDBCommonErrorResponse.self)))
            }
        }
    }
    
    func getTopRated(completion:@escaping(MovieDBResponse<PopularSeries>)->Void){
        
        AF.request(MDBEndpont.topRated).responseDecodable(of: PopularSeries.self) {
            switch $0.result{
            case.success(let topRatedFilms):completion(.success(topRatedFilms))
            case .failure(let errorFromServer):completion(.failure(HandleError($0, errorFromServer, MDBCommonErrorResponse.self)))
            }
        }
        
    }
    
    func getPopularPeople(completion:@escaping(MovieDBResponse<PopularPeople>)->Void){
        
        AF.request(MDBEndpont.popularPeople).responseDecodable(of: PopularPeople.self) { response in
            switch response.result{
            case.success(let popularPeople):completion(.success(popularPeople))
            case.failure(let errorFromServer):completion(.failure(HandleError(response, errorFromServer, MDBCommonErrorResponse.self)))
            }
        }
    }
    
    func getMorePopularPeople(page:Int,completion:@escaping(MovieDBResponse<PopularPeople>)->Void){
    
        AF.request(MDBEndpont.morePopularPeople(_page: page)).responseDecodable(of: PopularPeople.self) { response in
            switch response.result{
            case.success(let popularPeople):completion(.success(popularPeople))
            case.failure(let errorFromServer):completion(.failure(HandleError(response, errorFromServer, MDBCommonErrorResponse.self)))
            }
        }
    }
    
    func getPopularPeopleDetail(id:Int,completion:@escaping(MovieDBResponse<PeopleDetailResponse>)->Void){

        AF.request(MDBEndpont.popularPeopleDetail(_personID: id)).responseDecodable(of: PeopleDetailResponse.self) {
            switch $0.result{
            case.success(let peopleDetailRes):completion(.success(peopleDetailRes))
            case.failure(let errorFromserver):completion(.failure(HandleError($0, errorFromserver, MDBCommonErrorResponse.self)))
            }
        }
    }
    
    func getCreditActorList(id:Int,completion:@escaping(MovieDBResponse<CreditActorList>)->Void){

        AF.request(MDBEndpont.movieCreditActor(_movieID: id)).responseDecodable(of: CreditActorList.self) {
            switch $0.result{
            case.success(let creditActorList):completion(.success(creditActorList))
            case.failure(let errorFromServer):completion(.failure(HandleError($0, errorFromServer, MDBCommonErrorResponse.self)))
            }
        }
    }
    
    func getCredicActorForSeries(ID:Int,completion:@escaping(MovieDBResponse<CreditActorList>)->Void){
        
        AF.request(MDBEndpont.seriesCreitActor(_seriesID: ID)).responseDecodable(of: CreditActorList.self) {
            switch $0.result{
            case.success(let creditTVList):completion(.success(creditTVList))
            case .failure(let errorFromServer):completion(.failure(HandleError($0, errorFromServer, MDBCommonErrorResponse.self)))
            }
        }
        
    }
    
    func fetchDetailsForSeries(dataID:Int,completion:@escaping(MovieDBResponse<SeriesDetailResponse>)->Void){

        AF.request(MDBEndpont.seriesDetail(_seriesID: dataID)).responseDecodable(of: SeriesDetailResponse.self) {
            
            switch $0.result{
            case.success(let seriesDetailResponse):completion(.success(seriesDetailResponse))
            case.failure(let errorFromServer):completion(.failure(HandleError($0, errorFromServer, MDBCommonErrorResponse.self)))
            }
        }
    }
    
    func fetchActorMovies(actorID:Int,completion:@escaping(MovieDBResponse<CastStarAt>)->Void){
        
        AF.request(MDBEndpont.moviesWhichActorsStarAt(_personID: actorID)).responseDecodable(of: CastStarAt.self) {
            switch $0.result{
            case.success(let castStaringFilms):completion(.success(castStaringFilms))
            case.failure(let errorFromServer):completion(.failure(HandleError($0, errorFromServer, MDBCommonErrorResponse.self)))
            }
        }
       
        
    }
    
    func fetchMovieListForUserSearch(page:Int,query:String,completion:@escaping(MovieDBResponse<PopularSeries>)->Void){
        
        AF.request(MDBEndpont.searchMovieList(_page: page, _query: query)).responseDecodable(of: PopularSeries.self) {
            switch $0.result{
            case.success(let searchMovieList):completion(.success(searchMovieList))
            case.failure(let errorFromServer):completion(.failure(HandleError($0, errorFromServer, MDBCommonErrorResponse.self)))
            }
        }
    }
    
    func getMoreSeries(page:Int,completion:@escaping(MovieDBResponse<PopularSeries>)->Void){

        AF.request(MDBEndpont.getMoreSeries(_page: page)).responseDecodable(of: PopularSeries.self) {
            switch $0.result{
            case.success(let popularSeries):completion(.success(popularSeries))
            case.failure(let errorFromServer):completion(.failure(HandleError($0, errorFromServer, MDBCommonErrorResponse.self)))
            }
            
        }
        
    }
    
   
    
    
//   Network Error - Different Scenarios
//
//    * Json Serialization
//    * Wrong URL Path
//    * Incorrect Method
//    * Missing Credentials
//    * 4xx
//    * 5xx
    
    //Customize ErrorBody
    fileprivate func HandleError<T , E:MDBErrorModel>
    (_ response:DataResponse<T,AFError>,_ error:(AFError),_ errorBodyTime:E.Type)->String
   
    {
        
        var respBody:String = ""
        
        var serverErrorMessage:String?
        
        var errorBody:E?
        
        if let respData = response.data{
            respBody = String(data: respData, encoding: .utf8) ?? "Empty response Body"
            
            errorBody = try?JSONDecoder().decode(errorBodyTime, from: respData)
            serverErrorMessage = errorBody?.meesage
        }
        
        let respCode = response.response?.statusCode ?? 0
        
        let sourcePath = response.request?.url?.absoluteString ?? "no url"
        
        
        //Essential Debug Info
        print(
           """
            ===========
            URL
            ->\(sourcePath)
           
            Status
            ->\(respCode)
           
            Body
            ->\(serverErrorMessage ?? "")
           
           Underlying Errror
            ->\(error.underlyingError!)
           
           Error.Description
            ->\(error.errorDescription ?? "")
            ============
           
           """
        
        )
        return serverErrorMessage ?? error.errorDescription ?? "undefined"
    }
    
    
}

protocol MDBErrorModel : Decodable {
    var meesage:String{ get }
}

class MDBCommonErrorResponse:MDBErrorModel
{
    var meesage: String
    {
        return statusMessage ?? ""
    }
    
    let statusMessage:String?
    let statusCode:String?
    
    enum CodingKeys:String,CodingKey
    {
        case statusMessage = "status_message"
        case statusCode = "status_code"
    }
    
}

public enum MovieDBResponse<T>{
    case success(T)
    case failure(String)
}
