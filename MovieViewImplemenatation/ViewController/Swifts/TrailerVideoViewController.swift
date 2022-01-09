//
//  TrailerVideoViewController.swift
//  MovieViewImplemenatation
//
//  Created by Aung Ko Ko on 06/07/2021.
//

import UIKit
import YouTubePlayer

class TrailerVideoViewController: UIViewController {

    @IBOutlet weak var trailerItemCollectionView: UICollectionView?
    //    @IBOutlet weak var youtubePlayerView: YouTubePlayerView!
    
    var dataReceivedFromMoreActors:PopularPeople?{
        didSet{
            if let _ = dataReceivedFromMoreActors{
                
//                self.arrayAppending?.append(contentsOf: arrayAccept ?? [])
                self.totalPage = dataReceivedFromMoreActors?.totalPages ?? 0
                self.currentPage = dataReceivedFromMoreActors?.page ?? 0
                self.arrayAppending.append(contentsOf: dataReceivedFromMoreActors?.results ?? [])
                self.trailerItemCollectionView?.reloadData()
                debugPrint("data isn't empty")
               
            } else{
                debugPrint("Your data is empty.")
            }
        }
    }
    
   
    
    var arrayAppending:[PeopleDetail] = []
        
    private var trailerModel:TrailerModel = TrailerModelImplementation.shared
    private var actorModel:ActorModel = ActorModelImplementation.shared
    
   
    
    
    var trailerListForSeries:[TrailerItems]?{
        didSet{
            if let _ = trailerListForSeries{
                self.trailerItemCollectionView?.reloadData()
            }
        }
    }

//    var data:String?=nil
    var trailerListForMovies:[TrailerItems]?{
        didSet{
            if let _ = trailerListForMovies{
//                self.trailerItemCollectionView.reloadData()
                
                if let _ = trailerItemCollectionView {
                    trailerItemCollectionView?.reloadData()
                    debugPrint("The collectionView is initialized")
                } else{
                    debugPrint("The CollectionView is not initialized")
                }
//                debugPrint(trailerList?[0].key ?? "")
               
            }else{
                debugPrint("trailefList is nil")
            }
        }
    }
    
    var currentPage:Int = 1
    
    var totalPage:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDataSourceAndDelegate()
        registerCells()
        

    }
    
    func registerCells(){
        trailerItemCollectionView?.registerCollectionViewCells(identifier: TrailerMovieItemCollectionViewCell.identifier)
        trailerItemCollectionView?.registerCollectionViewCells(identifier: bestPlayersAnimeCollectionViewCell.identifier)
    }
    
    private func fetchNewActorList(pageID:Int){
        actorModel.getMorePopularPeople(page: pageID) { [weak self]data in
            guard let self = self else{return}
            switch data{
            case.success(let data):self.dataReceivedFromMoreActors = data
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
            
//
            
        }

    }
    
    func setDataSourceAndDelegate()
    {
        trailerItemCollectionView?.dataSource = self
        trailerItemCollectionView?.delegate = self
    }
    @IBAction func onTapClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TrailerVideoViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var returnCellCount:Int?
        
        if let _ = trailerListForMovies{
            returnCellCount = trailerListForMovies?.count ?? 0
        }
        
        if let _ = trailerListForSeries{
            returnCellCount = trailerListForSeries?.count ?? 0
        }
        if let _ = dataReceivedFromMoreActors{
            returnCellCount = arrayAppending.count
            
        }
        
        return returnCellCount ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cellToReturn:UICollectionViewCell?
        
        if let _ = trailerListForMovies{
            guard let cell = trailerItemCollectionView?.dequeReusableCells(identifier: TrailerMovieItemCollectionViewCell.identifier, indexPath: indexPath) as? TrailerMovieItemCollectionViewCell else{
                return UICollectionViewCell()
            }
            cell.data = trailerListForMovies?[indexPath.row].key
            cellToReturn = cell
        }
        
        if let _ = trailerListForSeries{
            guard let cell = trailerItemCollectionView?.dequeReusableCells(identifier: TrailerMovieItemCollectionViewCell.identifier, indexPath: indexPath) as? TrailerMovieItemCollectionViewCell else{
                return UICollectionViewCell()
            }
            cell.data = trailerListForSeries?[indexPath.row].key
            cellToReturn = cell
        }
        if let _ = dataReceivedFromMoreActors{
            guard let cell = trailerItemCollectionView?.dequeReusableCells(identifier: bestPlayersAnimeCollectionViewCell.identifier, indexPath: indexPath) as? bestPlayersAnimeCollectionViewCell else{
                return UICollectionViewCell()
            }
            cell.data = arrayAppending[indexPath.row]
            cellToReturn = cell
        }
        
        return cellToReturn ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width:CGFloat?
        var height:CGFloat?
        
        if let _ = trailerListForMovies{
            width =  trailerItemCollectionView?.bounds.width ?? 0
            height =  220
        }
        if let _ = trailerListForSeries{
            width =  trailerItemCollectionView?.bounds.width ?? 0
            height =  220
        }
        if let _ = dataReceivedFromMoreActors{
            width =  120
            height =  240
        }
        return CGSize(width: width ?? 0, height: height ?? 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let _ = dataReceivedFromMoreActors{
            navToDetailScreenForPopularPeople(idToBind: arrayAppending[indexPath.row].id ?? 0)
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
         
        if let _ = dataReceivedFromMoreActors{
        
        let isLastRow = indexPath.row == (dataReceivedFromMoreActors?.results?.count ?? 0) - 1
            let hasMorePages = currentPage < totalPage
            if isLastRow && hasMorePages{
                currentPage = currentPage  + 1
                fetchNewActorList(pageID: currentPage)
            }
        }
    }
    
}
