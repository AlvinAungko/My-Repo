//
//  MovieViewController.swift
//  MovieViewImplemenatation
//
//  Created by AungKoKo on 24/01/2021.
//

import Foundation
import UIKit

class MovieViewController : UIViewController{
    
    @IBOutlet weak var movieTableView: UITableView!
   
    
    private var movieModel:MovieModel = MovieModelImplementation.shared
    private var seriesModel:SeriesModel = SeriesModelImplementation.shared
    private var actorModel:ActorModel = ActorModelImplementation.shared
    
    
    private var dataToPass:UpcomingMovie?
    
    private var dataToPassToSeries:PopularSeries?
    
    private var dataToPassToGenre:GenreStruct?
    
    private var dataToPassToShowCase:PopularSeries?
    
    private var dataPassToPopularPerson:PopularPeople?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        setUpDataSourceAndDelegate()
        registerCells()
        getUpcomingMovies()
        getPopularMovies()
        getPopularSeries()
        getTopRated()
        getGenre()
        getPopularPeople()
        navigationItem.backBarButtonItem = UIBarButtonItem()
       
    }
    
    @IBAction func onTapSearchBut(_ sender: Any) {
        navigateToSearchVC()
    }
    func getPopularPeople(){
        
        actorModel.getPopularPeople { [weak self]data in
            guard let self = self else{return}
            switch data{
            case.success(let data):
                self.movieTableView.reloadSections(IndexSet(integer: 6), with: .automatic)
                self.dataPassToPopularPerson = data
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
        }
    }
    
    
    func getTopRated(){
        seriesModel.getTopRated { [weak self]topRatedFilms in
            guard let self = self else{return}
            switch topRatedFilms
            {
            case.success(let topRatedFilms ):
                self.movieTableView.reloadSections(IndexSet(integer: 5), with: .automatic)
                self.dataToPassToShowCase = topRatedFilms
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
            
        }

    }
    
    func setUpDataSourceAndDelegate(){
        movieTableView.dataSource = self
    }
    
    func registerCells(){
        movieTableView.registerCells(identifier: MovieTableViewCell.identifier)
        movieTableView.registerCells(identifier: FeatureMovie_TableViewCell.identifier)
        movieTableView.registerCells(identifier: Movieshowtime_TableViewCell.identifier)
        movieTableView.registerCells(identifier: Genre_TableViewCell.identifier)
        movieTableView.registerCells(identifier: ShowCaseTableViewCell.identifier)
        movieTableView.registerCells(identifier: BestActorTableViewCell.identifier)
    }
    
    func getGenre(){
        movieModel.getGenre( completion: { [weak self]
            data in
            guard let self = self else{return}
            switch data
            {
            case.success(let data):self.movieTableView.reloadSections(IndexSet(integer: 4), with: .automatic)
                self.dataToPassToGenre = data
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
            
        })
    }
    
    
    func getUpcomingMovies(){
        movieModel.getUpcomingMovie( completion: {
            [weak self] data in
            guard let self = self else{return}
            switch data{
            case.success(let data): self.dataToPass = data
                
                self.movieTableView.reloadSections(IndexSet(integer:0), with: .automatic)
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
        
         })
    }
    
    func getPopularMovies(){
        movieModel.getPopularMovie( completion: {[weak self]data in
            guard let self = self else{return}
            switch data{
            case.success(_): self.movieTableView.reloadSections(IndexSet(integer: 1), with: .automatic)
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
           
            
        })
    }
    
    func getPopularSeries(){
        
        seriesModel.getBestSeries { [weak self]data in
            guard let self = self else{return}
            switch data{
            case.success(let data): self.movieTableView.reloadData()
                self.dataToPassToSeries = data
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
           
        
        }

    }
    
}

extension MovieViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        
        case MovieType.Movie_slider.rawValue:
            let cell = movieTableView.dequeReuseCells(identifier:MovieTableViewCell.identifier, indexPath: indexPath) as MovieTableViewCell
            cell.delegate = self
            cell.data = dataToPass
            return cell
            
        
            
        case MovieType.Feature_Movie.rawValue:
            let cell = movieTableView.dequeReuseCells(identifier: FeatureMovie_TableViewCell.identifier, indexPath: indexPath) as FeatureMovie_TableViewCell
            cell.delegate = self
            cell.data = dataToPass
            return cell
            
        case MovieType.bestSeries.rawValue:
            let cell = movieTableView.dequeReuseCells(identifier: FeatureMovie_TableViewCell.identifier, indexPath: indexPath) as FeatureMovie_TableViewCell
            cell.delegate = self
            cell.dataForSeries = dataToPassToSeries
            return cell
            
        case MovieType.Movie_showtime.rawValue:
            return movieTableView.dequeReuseCells(identifier: Movieshowtime_TableViewCell.identifier, indexPath: indexPath)
            
        case MovieType.Movie_Genre.rawValue:
            guard let cell = movieTableView.dequeReuseCells(identifier: Genre_TableViewCell.identifier, indexPath: indexPath) as? Genre_TableViewCell else{
                return UITableViewCell()
            }
            cell.delegate = self
            let returnFromGenreCell:[GenreVo]? = dataToPassToGenre?.genres?.map({
                 $0.convertToGenreVO()
            })
            
          
     
            cell.movieArrayData = dataToPass?.results
            cell.genreList = returnFromGenreCell
            cell.genreList?.first?.isSelected = true
            return cell
            
        case MovieType.Showcase_Movie.rawValue:
            guard let cell = tableView.dequeReuseCells(identifier: ShowCaseTableViewCell.identifier, indexPath: indexPath) as? ShowCaseTableViewCell else{
                return UITableViewCell()
            }
            cell.delegate = self
            cell.dataFetchFromViewController = dataToPassToShowCase
            return cell
            
        case MovieType.Best_Actor.rawValue:
            guard let cell = tableView.dequeReuseCells(identifier: BestActorTableViewCell.identifier, indexPath: indexPath) as? BestActorTableViewCell else{
                return UITableViewCell()
            }
            cell.dataReceivedFromVC = dataPassToPopularPerson
            cell.delegate = self
            
            return cell
            
        default:
            return UITableViewCell()
        }
       
    }
    
}
extension MovieViewController:MovieItemDelegate
{
    func onTapMoreShowCase() {
        navigateToMoreShowcase()
    }
    
    func onTapMoreActors(object: PopularPeople) {
      navigateToNewVC(objectReceived: object)
    }
    
    
    
    func onTapPopularPeople(idToBind: Int) {
        navToDetailScreenForPopularPeople(idToBind: idToBind)
    }
    
    
    
    func onTapSeries(idToBind: Int) {
        forSeriesNavigateToDetailViewController(idToBind: idToBind, from: self)
    }
    
   
    func onTapMovie(iDToBind: Int) {
        navigateToDetailViewController(idReceivedFromTab: iDToBind,from:self)
    }
    
    
    
    
}
