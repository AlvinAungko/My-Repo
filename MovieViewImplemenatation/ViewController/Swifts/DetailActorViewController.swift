//
//  DetailActorViewController.swift
//  MovieViewImplemenatation
//
//  Created by Aung Ko Ko on 08/07/2021.
//

import UIKit
import SDWebImage

class DetailActorViewController: UIViewController {

    @IBOutlet weak var heightOfActorMovieCollectionView: NSLayoutConstraint!
    @IBOutlet weak var collectionViewTitle: UILabel!
    @IBOutlet weak var actorDescription: UILabel!
    @IBOutlet weak var actorBirthday: UILabel!
    @IBOutlet weak var actorImage: UIImageView!
    @IBOutlet weak var moviesThatActorStar: UICollectionView!
    @IBOutlet weak var actorName: UILabel!
    
    
    var delegate:MovieItemDelegate?{
        didSet{
            if let _ = delegate{
                print("Delegate is Initialized.")
            }
            else{
                print("Delegate is not initialized")
            }
        }
    }
    
    var actorID:Int?{
        didSet{
            if let _ = actorID{
                fetchActorDetail(actorID: actorID ?? 0)
                fetchActorMovies(actorID: actorID ?? 0)
            }
        }
    }
    
    private var actorDetailObjReceiver:PeopleDetailResponse?
    
    private var actorMovieObjReceiver:CastStarAt?{
        didSet{
            if let _ = actorMovieObjReceiver{
                self.moviesThatActorStar.reloadData()
            }
        }
    }
        
    private var actorModel:ActorModel = ActorModelImplementation.shared
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataSourceAndDelegate()
        registerCells()
        setUpHeight()
      
        
        
        
        if self.navigationController == nil{
            debugPrint("No Navi")
        } else{
            debugPrint("Navi is here.")
        }
    }
    
    private func setDataSourceAndDelegate(){
        moviesThatActorStar.delegate = self
        moviesThatActorStar.dataSource = self
    }
    
    private func registerCells(){
        moviesThatActorStar.registerCollectionViewCells(identifier: FeatureAnime_CollectionViewCell.identifier)
    }
    
    private func setUpHeight(){
        self.heightOfActorMovieCollectionView.constant = 340
    }
    
    private func fetchActorDetail(actorID:Int){
        actorModel.getPopularPeopleDetail(id: actorID) { [weak self]data in
            guard let self = self else{return}
            switch data
            {
            case.success(let data): self.bindUIWithDataFromServer(data: data)
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
           
        }
    }
    
    private func fetchActorMovies(actorID:Int){
        actorModel.fetchActorMovies(actorID: actorID) { data in
            switch data
            {
            case .success(let data):self.actorMovieObjReceiver = data
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
            
        }

    }
    
    private func bindUIWithDataFromServer(data:PeopleDetailResponse){
        navigationItem.title = data.name ?? ""
        self.actorBirthday.text = data.birthday ?? ""
        self.actorDescription.text = data.biography ?? ""
        self.actorName.text = data.name ?? ""
        
        let profile = data.profilePath ?? ""
        actorImage.sd_setImage(with: URL(string: "\(Constants.baseImageUrl)\(profile)"))
        
    }
    
    
    
    
}

extension DetailActorViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actorMovieObjReceiver?.cast?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = moviesThatActorStar.dequeReusableCells(identifier: FeatureAnime_CollectionViewCell.identifier, indexPath: indexPath) as? FeatureAnime_CollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.data = actorMovieObjReceiver?.cast?[indexPath.row].convertToResultObj()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: moviesThatActorStar.bounds.width/2.2, height: 340)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        navigateToDetailViewController(idReceivedFromTab: actorMovieObjReceiver?.cast?[indexPath.row].id ?? 0, from: self)
    }
}




