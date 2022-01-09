//
//  MovieDetailViewController.swift
//  MovieViewImplemenatation
//
//  Created by Aung Ko Ko on 01/06/2021.
//

import UIKit
import SDWebImage
//import YouTubePlayer

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var searchButton: UIImageView!
    @IBOutlet weak var fulldateLabel: UILabel!
    @IBOutlet weak var fullDateView: UIView!
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var ratingButton: UIButton!
    @IBOutlet weak var playTrailerButton: UIButton!
    @IBOutlet weak var stackViewToHideNumber2: UIStackView!
    @IBOutlet weak var viewToHideNumber3: UIView!
    
    @IBOutlet weak var stackViewToHideNumber1: UIStackView!
    @IBOutlet weak var heightOfMovieImageContent: NSLayoutConstraint!
    @IBOutlet weak var movieImageContentView: UIView!
    @IBOutlet weak var movieDescriptionView: UIView!
    @IBOutlet weak var movieListView: UIView!
    @IBOutlet weak var actorSimilarListToShow: UIView!
    @IBOutlet weak var viewToHideNumber1: UIView!
    @IBOutlet weak var viewToHideNumber2: UIView!
    
    @IBOutlet weak var similarMovieSeriesTitle: UILabel!
    @IBOutlet weak var productCreationTitle: UILabel!
    @IBOutlet weak var movieSimilarCollectionView: UICollectionView!
    @IBOutlet weak var similarMovieCollectionView: NSLayoutConstraint!
    @IBOutlet weak var heightOfActorCastCollectionView: NSLayoutConstraint!
    @IBOutlet weak var durationOfAMovie: UILabel!
    @IBOutlet weak var actorCollectionView: UICollectionView!
    @IBOutlet weak var movieSpecificCollectionView: UICollectionView!
    @IBOutlet weak var ivBackButton: UIImageView!
    @IBOutlet weak var movieDetailImage: UIImageView!
    @IBOutlet weak var movieOverallLabel: UILabel!
    @IBOutlet weak var dateOfMovieRelease: UILabel!
    @IBOutlet weak var lblProduction: UILabel!
    @IBOutlet weak var productionLBL: UIStackView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var descriptionOverAll: UILabel!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    @IBOutlet weak var voteCount: UILabel!
    @IBOutlet weak var ratingControlObject: RatingControl_StackView!
    @IBOutlet weak var releaseYear: UILabel!
    
    
    
    
    
    var idForActorFilms:Int?{
        didSet{
            if let _ = idForActorFilms{
                self.fetchActorFilmsFromServer(actorID: idForActorFilms ?? 0)
            }
        }
    }
    
    private var actorMovieStarList:[MoviesCastStar]?{
        didSet{
            if let _ = actorMovieStarList{
                self.movieSimilarCollectionView.reloadData()
            }
        }
    }
    
    
    var idForSeriesTrailer:Int?{
        didSet{
            if let  _ = idForSeriesTrailer{
                self.fetchTrailersForSpecificSeries(seriesId: idForSeriesTrailer ?? 0)
            }
        }
    }
    
    private var seriesTrailerList:[TrailerItems]?
    
    var idFortrailerToFetch:Int?{
        didSet{
            if let _ = idFortrailerToFetch{
                self.fetcMovieTrailerVideo(movieID: idFortrailerToFetch ?? 0)
            }
        }
    }
    
    private var dataReceivedFromTrailerServer:[TrailerItems]?
    
    
    private var dataToBindToProductionCellCreatedBy:[CreatedBy]?{
        didSet{
            if let _ = dataToBindToProductionCellCreatedBy{
                self.movieSpecificCollectionView.reloadData()
            }
            self.productCreationTitle.text = "Created By"
        }
    }
    
    
     var similarSeriesID:Int?{
        didSet{
            if let _ = similarSeriesID{
                self.getSimilarSeries(dataTofetch: similarSeriesID ?? 0)
            }
        }
    }
    
     var creditListIDSeries:Int?{
        didSet{
            if let _ = creditListIDSeries{
                self.getCreditSeries(dataToFetch: creditListIDSeries ?? 0)
            }
        }
    }
    
    
    private var  similarSerisBind:PopularSeries?{
        didSet{
            if let _ = similarSerisBind{
                self.movieSimilarCollectionView.reloadData()
            }
            self.similarMovieSeriesTitle.text = "Similar Series"
        }
    }
    
    private var creditCastForSeries:CreditActorList?{
        didSet{
            if let _ = creditCastForSeries{
                self.actorCollectionView.reloadData()
            }
        }
    }
    
    
    
    private var dataToBindToProductionCell:[ProductionCompany]?{
        didSet{
            if let _ = dataToBindToProductionCell{
                self.movieSpecificCollectionView.reloadData()
            }
        }
    }
    
    var similarID:Int?{
        didSet{
            if let _ = similarID{
                self.getSimilar(idToFetch: similarID ?? 0)
            }
            debugPrint(similarID ?? 0)
        }
    }
    
    
    var similarMovieList:UpcomingMovie?{
        didSet{
            if let _ = similarMovieList{
                self.movieSimilarCollectionView.reloadData()
                debugPrint("Value Received?")
            }
        }
    }
    
    
    var creditActorList:CreditActorList?{
        didSet{
            if let _ = creditActorList{
        self.actorCollectionView.reloadData()
                
            }
        }
    }
    
    var creditID:Int?{
        didSet{
            if let _ = creditID{
                getCastCreditList(dataToFetch: creditID ?? 0)
            }
        }
    }
    
    var genreSeries:Int?{
        didSet{
            if let _ = genreSeries{
                self.fetchDataFromSeries(dataID: genreSeries ?? 0)
                
            }
            debugPrint("The value is added.")
        }
    }
    
    var seriesID:Int?{
        didSet{
            if let _ = seriesID{
                self.fetchDataFromSeries(dataID: seriesID ?? 0)
                
            }
        }
    }
    var movieID:Int?{
        didSet{
            if let _ = movieID{
                self.fetchData(dataID: movieID ?? 0)
            }
        }
    }
    var popularPeopleIDkey:Int?{
        didSet{
            if let _ = popularPeopleIDkey{
                fetchDataForPopularPeople(dataBindId: popularPeopleIDkey ?? 0)
            }
        }
    }
   
    
    private var movieModel:MovieModel = MovieModelImplementation.shared
    private var seriesModel:SeriesModel = SeriesModelImplementation.shared
    private var actorModel:ActorModel = ActorModelImplementation.shared
    private var trailerModel:TrailerModel = TrailerModelImplementation.shared
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onTapButton()
        registerCells()
//        fetchData(dataID: movieID ?? 0)
//        fetchDataFromSeries(dataID: seriesID ?? 0)
        fullDateView.isHidden = true
//        readMoreButton.isHidden = true
        ivBackButton.isHidden = true
        searchButton.isHidden = true
        
        navigationItem.backBarButtonItem = UIBarButtonItem()
       
    }
    
    private func fetchActorFilmsFromServer(actorID:Int){
        actorModel.fetchActorMovies(actorID: actorID) { [weak self]response in
            guard let self = self else{return}
            switch response
            {
            case.success(let data):self.actorMovieStarList = data.cast
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
        }

    }
    
    private func fetchTrailersForSpecificSeries(seriesId:Int){
        trailerModel.getTrailerForSeries(seriesID: seriesId) {[weak self] data in
            guard let self = self else{return}
            switch data
            {
            case.success(let data):self.seriesTrailerList = data.results ?? []
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
        }

    }
    
    private func fetcMovieTrailerVideo(movieID:Int){
        trailerModel.getTrailerVideos(movieID: movieID) { [weak self]data in
            guard let self = self else{return}
            switch data{
            case.success(let data): self.dataReceivedFromTrailerServer = data.results ?? []
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
           
        }

    }
    
    
    private func getCreditSeries(dataToFetch:Int){
        seriesModel.getCredicActorForSeries(ID: dataToFetch) { [weak self]data in
            guard let self = self else{return}
            switch data{
            case.success(let data):self.creditCastForSeries = data
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
            
        }

    }
    
    private func getSimilarSeries(dataTofetch:Int){
        seriesModel.getSimilarSeries(id: dataTofetch) { [weak self]data in
            guard let self = self else{return}
            switch data
            {
            case.success(let data):self.similarSerisBind = data
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
            
        }

    }
    
    
    private func getSimilar(idToFetch:Int){
        movieModel.getSimilarMovies(dataToFetch: idToFetch) { [weak self]data in
            guard let self = self else{return}
            switch data{
            case.success(let data):self.similarMovieList = data
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
            
        }

    }
    
    private func getCastCreditList(dataToFetch:Int){
        movieModel.getCreditActorList(id: dataToFetch) { [weak self]data in
            guard let self = self else{return}
            switch data{
            case.success(let data):self.creditActorList = data
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
            
            
            
        }

        
    }
    
    private func fetchDataForPopularPeople(dataBindId:Int){
        
        actorModel.getPopularPeopleDetail(id: dataBindId) { [weak self]data in
            guard let self = self else{return}
            switch data
            {
            case .success(let data): self.dataBindToPopularPeopleDetail(data: data)
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
           
        }

    }
    
    private func fetchDataFromSeries(dataID:Int){
        seriesModel.fetchDetailsForSeries(dataID: dataID) { [weak self]data in
            guard let self = self else{return}
            switch data
            {
            case.success(let data):
                self.dataBindToSeries(data: data)
                self.dataToBindToProductionCellCreatedBy = data.createdBy
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
          
            
        
        }

    }
    
    private func fetchData(dataID:Int){
        movieModel.fetchDetail(dataID: dataID) { [weak self]data in
            guard let self = self else{return}
            switch data {
            case.success(let data):
                self.dataBind(data: data)
                self.dataToBindToProductionCell = data.productionCompanies
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
            
            
        }


    }
    
    private func setUpHeight(){
        self.heightOfActorCastCollectionView.constant = 240
    }
    
    
    private func registerCells()
    {
        movieSpecificCollectionView.delegate = self
        movieSpecificCollectionView.dataSource = self
        movieSpecificCollectionView.registerCollectionViewCells(identifier: ProductionCompanyCollectionViewCell.identifier)
        movieSpecificCollectionView.registerCollectionViewCells(identifier: CreatorCollectionViewCell.identifier)
        
        actorCollectionView.delegate = self
        actorCollectionView.dataSource = self
        actorCollectionView.registerCollectionViewCells(identifier: bestPlayersAnimeCollectionViewCell.identifier)
        actorCollectionView.registerCollectionViewCells(identifier: CreatorCollectionViewCell.identifier)
        
        movieSimilarCollectionView.delegate = self
        movieSimilarCollectionView.dataSource = self
        movieSimilarCollectionView.registerCollectionViewCells(identifier: FeatureAnime_CollectionViewCell.identifier)
        
    }
    @IBAction func onTapPlayTrailer(_ sender: Any) {
    
       let vcYoutubePlayer = TrailerVideoViewController()
        
        vcYoutubePlayer.modalPresentationStyle = .fullScreen
        vcYoutubePlayer.modalTransitionStyle = .coverVertical
        self.navigationController?.pushViewController(vcYoutubePlayer, animated: true)
        
       
        vcYoutubePlayer.trailerListForMovies = dataReceivedFromTrailerServer
       
        vcYoutubePlayer.trailerListForSeries = seriesTrailerList
        
       
        
        
    }
    private func onTapButton(){
        let guestureRecog = UITapGestureRecognizer(target: self, action: #selector(onTapBack))
        ivBackButton.isUserInteractionEnabled = true
        ivBackButton.addGestureRecognizer(guestureRecog)
    }
    @objc func onTapBack(){
        self.dismiss(animated: true, completion: nil)
        
    }

}
extension MovieDetailViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
      
    
    
    
    
    private func dataBind(data:MovieDetailResponse){
//       movieDetailImage: UIImageView!
        let imageUrl = data.backdropPath ?? ""
        movieDetailImage.sd_setImage(with: URL(string: "\(Constants.baseImageUrl)\(imageUrl)"))

        movieOverallLabel.text = data.overview ?? ""
        
        navigationItem.title = data.title ?? ""
        
        var productData = ""
        var category = ""
        data.productionCountries?.forEach({ data in
            productData += data.name ?? ""
        })
        
        data.genres?.forEach({ data in
            category += data.name ?? ""
        })
        
        lblProduction.text = productData
        
        lblCategory.text = category
        lblMovieName.text = data.title ?? ""
        descriptionOverAll.text = data.overview ?? ""
        
        movieName.text = data.originalTitle ?? ""
        voteAverage.text = String(data.voteAverage ?? 0.0)
        
        
        voteCount.text = "\(data.voteCount ?? 0) votes"
        ratingControlObject.rating = Int(data.voteAverage ?? 0.0)/2
        let durationMinute = ( data.runtime ?? 0) % 60
        let durationHr = (data.runtime ?? 0)/60
        durationOfAMovie.text = "\(durationHr) hrs and \(durationMinute)mins"
        releaseYear.text = String( data.releaseDate?.split(separator: "-")[0] ?? "")
        dateOfMovieRelease.text = data.releaseDate ?? ""
        
    }
    
    private func dataBindToSeries(data:SeriesDetailResponse){
        
        let imageUrl = data.backdropPath ?? ""
        movieDetailImage.sd_setImage(with: URL(string: "\(Constants.baseImageUrl)\(imageUrl)"))

        movieOverallLabel.text = data.overview ?? ""
        
        navigationItem.title = data.name ?? ""
        
        var productData = ""
        var category = ""
        data.productionCountries?.forEach({ data in
            productData += data.name ?? ""
        })
        
        data.genres?.forEach({ data in
            category += data.name ?? ""
        })
        
        lblProduction.text = productData
        
        lblCategory.text = category
        lblMovieName.text = data.originalName ?? ""
        descriptionOverAll.text = data.overview ?? ""
        
        movieName.text = data.name ?? ""
        voteAverage.text = String(data.voteAverage ?? 0.0)
        
        
        voteCount.text = "\(data.voteCount ?? 0) votes"
        ratingControlObject.rating = Int(data.voteAverage ?? 0.0)/2
//        let durationMinute = ( data. ?? 0) % 60
//        let durationHr = (data.runtime ?? 0)/60
//        durationOfAMovie.text = "\(durationHr) hrs and \(durationMinute)mins"
        releaseYear.text = String( data.firstAirDate?.split(separator: "-")[0] ?? "")
        dateOfMovieRelease.text = data.firstAirDate ?? ""
        
    }
    
    private func dataBindToPopularPeopleDetail(data:PeopleDetailResponse){
        
        let imageUrl = data.profilePath ?? ""
        movieDetailImage.sd_setImage(with: URL(string: "\(Constants.baseImageUrl)\(imageUrl)"))

        movieOverallLabel.text = data.biography ?? ""
        fulldateLabel.text = data.birthday ?? ""
        
        
//        var productData = ""
//        var category = ""
//        data.productionCountries?.forEach({ data in
//            productData += data.name ?? ""
//        })
//
//        data.genres?.forEach({ data in
//            category += data.name ?? ""
//        })
        
        navigationItem.title = data.name ?? "Empty"
        
        lblCategory.text = data.knownForDepartment ?? ""
        lblMovieName.text = data.placeOfBirth ?? ""
        descriptionOverAll.text = data.biography ?? ""
        
        movieName.text = data.name ?? ""
        voteAverage.text = String(data.popularity ?? 0.0)
        
        
       
//        let durationMinute = ( data. ?? 0) % 60
//        let durationHr = (data.runtime ?? 0)/60
//        durationOfAMovie.text = "\(durationHr) hrs and \(durationMinute)mins"
        releaseYear.text = String( data.birthday?.split(separator: "-")[0] ?? "")
        dateOfMovieRelease.text = data.birthday ?? ""
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == movieSpecificCollectionView{
            var returnCellCount:Int?
            if let data = dataToBindToProductionCell{
                returnCellCount = data.count
            }
            if let data = dataToBindToProductionCellCreatedBy{
                returnCellCount = data.count
            }
            return returnCellCount ?? 0
        }
        else if collectionView == actorCollectionView{
            var returnCellCount:Int?
            if let data = creditActorList{
                returnCellCount = data.cast?.count ?? 0
            }
            if let data = creditCastForSeries{
                returnCellCount = data.cast?.count ?? 0
            }
            return returnCellCount ?? 0
        }
        else  {
            var returnCellCount:Int?
            if let data = similarMovieList{
                returnCellCount = data.results?.count ?? 0
            }
            if let data = similarSerisBind{
                returnCellCount = data.results?.count ?? 0
            }
            if let data = actorMovieStarList{
                returnCellCount = data.count ?? 0
            }
            return returnCellCount ?? 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == movieSpecificCollectionView{
            var returnCell:UICollectionViewCell?
            
            if let _ = dataToBindToProductionCell{
                guard let cell = movieSpecificCollectionView.dequeReusableCells(identifier: ProductionCompanyCollectionViewCell.identifier, indexPath: indexPath) as? ProductionCompanyCollectionViewCell else{return UICollectionViewCell()}
                cell.data = dataToBindToProductionCell?[indexPath.row]
                returnCell = cell
            }
            
            if let _ = dataToBindToProductionCellCreatedBy{
                guard let cell = movieSpecificCollectionView.dequeReusableCells(identifier: CreatorCollectionViewCell.identifier, indexPath: indexPath) as? CreatorCollectionViewCell else{return UICollectionViewCell()}
                cell.data = dataToBindToProductionCellCreatedBy?[indexPath.row].convertToPeopleDetail()
                returnCell = cell
            }
            return returnCell ?? UICollectionViewCell()
            
        }
        else if collectionView == actorCollectionView{
            var returnCell:UICollectionViewCell?
            
            if let _ = creditActorList{
                guard let cell = actorCollectionView.dequeReusableCells(identifier: bestPlayersAnimeCollectionViewCell.identifier, indexPath: indexPath) as? bestPlayersAnimeCollectionViewCell else{return UICollectionViewCell()}
                cell.data = creditActorList?.cast?[indexPath.row].convertToPopularPeopleList()
                returnCell = cell
            }
            
            if let _ = creditCastForSeries{
                guard let cell = actorCollectionView.dequeReusableCells(identifier: bestPlayersAnimeCollectionViewCell.identifier, indexPath: indexPath) as? bestPlayersAnimeCollectionViewCell else{return UICollectionViewCell()}
                cell.data = creditCastForSeries?.cast?[indexPath.row].convertToPopularPeopleList()
                returnCell = cell
            }
            
            return returnCell ?? UICollectionViewCell()
        }
        else {
            var returnCell:UICollectionViewCell?
            
            if let _ = similarMovieList{
                guard let cell = movieSimilarCollectionView.dequeReusableCells(identifier: FeatureAnime_CollectionViewCell.identifier, indexPath: indexPath) as? FeatureAnime_CollectionViewCell else{return UICollectionViewCell()}
                cell.data = similarMovieList?.results?[indexPath.row]
                returnCell = cell
            }
            
            if let _ = similarSerisBind{
                guard let cell = movieSimilarCollectionView.dequeReusableCells(identifier: FeatureAnime_CollectionViewCell.identifier, indexPath: indexPath) as? FeatureAnime_CollectionViewCell else{return UICollectionViewCell()}
                cell.data = similarSerisBind?.results?[indexPath.row].convertToResultObject()
                returnCell = cell
            }
            
            if let _ = actorMovieStarList{
                guard let cell = movieSimilarCollectionView.dequeReusableCells(identifier: FeatureAnime_CollectionViewCell.identifier, indexPath: indexPath) as? FeatureAnime_CollectionViewCell else{return UICollectionViewCell()}
                cell.data = actorMovieStarList?[indexPath.row].convertToResultObj()
                returnCell = cell
            }
            
            return returnCell ?? UICollectionViewCell()
           
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == actorCollectionView{
        
        if let _ = creditCastForSeries{
            let actorId = creditCastForSeries?.cast?[indexPath.row].id ?? 0
            navToDetailScreenForPopularPeople(idToBind: actorId)
            

        }
        if let _ = creditActorList{
            let actorId = creditActorList?.cast?[indexPath.row].id ?? 0
            navToDetailScreenForPopularPeople(idToBind: actorId)
            
//
        }
        } else if collectionView ==  movieSimilarCollectionView{
            if let _ = similarMovieList{
                let id = similarMovieList?.results?[indexPath.row].id ?? 0
                navigateToDetailViewController(idReceivedFromTab: id, from: self)
            }
            if let _ = similarSerisBind{
                let id = similarSerisBind?.results?[indexPath.row].id ?? 0
                forSeriesNavigateToDetailViewController(idToBind: id, from: self)
            }
        } else{
            debugPrint("")
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == movieSpecificCollectionView{
            var width:CGFloat?
            var height:CGFloat?
            
            if let _ = dataToBindToProductionCell{
                width =  actorCollectionView.frame.width/2.3
              height =  200
            }
            
            if let _ = dataToBindToProductionCellCreatedBy{
                width =  actorCollectionView.frame.width/2.3
                height =  280
            }
            return CGSize(width: width ?? 0.0, height: height ?? 0.0)
        }
        else if collectionView == actorCollectionView{
            return CGSize(width: actorCollectionView.frame.width/2.3, height: 240)
        }
         else{
            
            var width:CGFloat?
            var height:CGFloat?
            
            if let _ = similarMovieList{
                width =  actorCollectionView.frame.width/2.3
              height =  340
            }
            
            if let _ = similarSerisBind{
                width =  actorCollectionView.frame.width/2.3
                height =  340
            }
            if let _ = actorMovieStarList{
                width =  actorCollectionView.frame.width/2.3
                height =  340
            }
            return CGSize(width: width ?? 0.0, height: height ?? 0.0)
        }
    }
}
