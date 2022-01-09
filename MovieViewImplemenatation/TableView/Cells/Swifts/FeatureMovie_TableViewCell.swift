//
//  FeatureMovie_TableViewCell.swift
//  MovieViewImplemenatation
//
//  Created by AungKoKo on 26/01/2021.
//

import UIKit

class FeatureMovie_TableViewCell: UITableViewCell {

    @IBOutlet weak var labelForBestMovie: UILabel!
    var delegate:MovieItemDelegate?=nil
    var check:[String]?
   
    var data:UpcomingMovie?{
        didSet{
            if let _ = data{
                featureMovieList.reloadData()
            }
            labelForBestMovie.text = "Best Movies"
        }
    }
    
    var dataForSeries:PopularSeries?{
        
        didSet{
            if let data = dataForSeries{
                self.featureMovieList.reloadData()
                   (data.results?.forEach({
                    debugPrint($0.overview ?? "")
                }))
                
            }
            labelForBestMovie.text = "Best Series"
        }
    }
    
    @IBOutlet weak var lb_Caption: UILabel!
    @IBOutlet weak var featureMovieList: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        featureMovieList.registerCollectionViewCells(identifier: FeatureAnime_CollectionViewCell.identifier)
        featureMovieList.delegate = self
        featureMovieList.dataSource = self
        labelForBestMovie.text = "Best Movies."
        featureMovieList.registerCollectionViewCells(identifier: BestSeriesCollectionViewCell.identifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension FeatureMovie_TableViewCell: UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        var returnCount = Int()
        
        if let data = data{
            returnCount = data.results?.count ?? 0
        }
        if let dataFrSeries = dataForSeries{
            returnCount = dataFrSeries.results?.count ?? 0
        }
        return returnCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cellA:UICollectionViewCell?
       
        
        if let data = data{
        guard let cell = collectionView.dequeReusableCells(identifier: FeatureAnime_CollectionViewCell.identifier, indexPath: indexPath)as?FeatureAnime_CollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.data = data.results?[indexPath.row]
        cellA = cell
        
    }
        
        if let data = dataForSeries{
        guard let cell = collectionView.dequeReusableCells(identifier: BestSeriesCollectionViewCell.identifier, indexPath: indexPath)as?BestSeriesCollectionViewCell else{
            return UICollectionViewCell()
        }
            cell.data = data.results?[indexPath.row]
            cellA = cell
    }
        return cellA ?? UICollectionViewCell()
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let data = data{
        let idToCombine = data.results?[indexPath.row].id ?? 0
        
        self.delegate?.onTapMovie(iDToBind: idToCombine)
        }
        if let dataForSeries = dataForSeries{
            debugPrint("Is This worked.")
            let idToCombine =  dataForSeries.results?[indexPath.row].id ?? 0
            
           
            self.delegate?.onTapSeries(idToBind: idToCombine)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var itemHeight:CGFloat?
        var itemWidth:CGFloat?
        
        if let _ = data{
            itemWidth = featureMovieList.frame.width/2.2
            itemHeight = CGFloat(340)
        }
        if let _ = dataForSeries{
            itemWidth = featureMovieList.frame.width/2.2
            itemHeight = CGFloat(340)
        }
        
        
        return CGSize(width: itemWidth ?? CGFloat(0), height: itemHeight ?? CGFloat(0))
    }
}
