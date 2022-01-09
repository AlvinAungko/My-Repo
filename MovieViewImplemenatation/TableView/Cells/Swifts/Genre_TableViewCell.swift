//
//  Genre_TableViewCell.swift
//  MovieViewImplemenatation
//
//  Created by AungKoKo on 30/01/2021.
//

import UIKit

class Genre_TableViewCell: UITableViewCell{
    

//    var delegateForGenre:GenreItemDelegate?=nil
    var delegate:MovieItemDelegate?
    var movieArrayData:[Result]? {
        
        didSet{
            if let data = movieArrayData{
                data.forEach({
                    result in result.genreIDS?.forEach({ idKey in
                        let idKeyForUsage = idKey
                        
                        if var _ = movieListByGenre[idKeyForUsage]{
                            movieListByGenre[idKeyForUsage]?.insert(result)
                        } else{
                            movieListByGenre[idKeyForUsage] = [result]
                        }
                    })
                })
               
            }
//            self.CollecionView_Movie.reloadData()
            onTap(id: movieListByGenre.first?.key ?? 0)
        }
        
    }
    private var selectedMovieList:[Result]?{
        didSet{
            if let _ = selectedMovieList{
                self.CollecionView_Movie.reloadData()
            }
        }
    }
   
    var genreList:[GenreVo]?{
        didSet{
            if let _ = genreList{
                
                
                genreList?.removeAll { genreVo in
                      let idToMatch = genreVo.id
                   let newMovieDictinoaryArray = movieListByGenre.filter { key,value in
                        return idToMatch == key
                    }
                    debugPrint("newMovieDictinoaryArray.count = \(newMovieDictinoaryArray.count)")
                    return newMovieDictinoaryArray.count == 0
                }
                self.CollectionView_General.reloadData()
            }
              
            
        }
        
        
    }
    
    
    
    var movieListByGenre:[Int:Set<Result>] = [Int:Set<Result>]()
    
    @IBOutlet weak var CollecionView_Movie: UICollectionView!
    @IBOutlet weak var CollectionView_General: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        CollectionView_General.dataSource = self
        CollectionView_General.delegate = self
        CollectionView_General.registerCollectionViewCells(identifier: Genre_CollectionViewCell.identifier)
        
        CollecionView_Movie.dataSource = self
        CollecionView_Movie.delegate = self
        CollecionView_Movie.registerCollectionViewCells(identifier: FeatureAnime_CollectionViewCell.identifier)
        
        debugPrint(movieListByGenre)
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension Genre_TableViewCell : UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return genreList.count
//
//    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == CollecionView_Movie{
            return selectedMovieList?.count ?? 0
        }
        else
        {
            return genreList?.count ?? 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == CollecionView_Movie{

            let idKey = selectedMovieList?[indexPath.row].id ?? 0
            debugPrint("The item is tabbed . ")
            delegate?.onTapMovie(iDToBind: idKey)
            
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == CollecionView_Movie{
            
            guard let cell = CollecionView_Movie.dequeReusableCells(identifier: FeatureAnime_CollectionViewCell.identifier, indexPath: indexPath) as? FeatureAnime_CollectionViewCell else{
                return UICollectionViewCell()
            }
            cell.data = selectedMovieList?[indexPath.row]
          
            return cell
            
        }
        guard let cell = CollectionView_General.dequeueReusableCell(withReuseIdentifier: String(describing: Genre_CollectionViewCell.self), for: indexPath) as? Genre_CollectionViewCell else{
            return UICollectionViewCell()
        }
       
        cell.data = genreList?[indexPath.row]
        cell.onTap = { id in
            
            self.onTap(id: id)
        }
     
        return cell
    }
    
    func onTap(id:Int){
        self.genreList?.forEach{
            (GenreVo) in
            if id == GenreVo.id{
                GenreVo.isSelected = true
            }
            else{
                GenreVo.isSelected = false
            }
        }
        let movieListByGenreId = self.movieListByGenre[id]
        self.selectedMovieList = movieListByGenreId?.map({
            $0
        })
        
        self.CollecionView_Movie.reloadData()
        self.CollectionView_General.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                            UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == CollecionView_Movie{
            return CGSize(width: CollecionView_Movie.frame.width/2.2, height: CGFloat(340))
        }else{
            return CGSize(width: widthOfString(text: genreList?[indexPath.row].name ?? "", font: UIFont(name: "Futura", size: 14) ?? UIFont.systemFont(ofSize: 14))+50, height: 50)
        }
//        return CGSize(width: 100, height: 50)
    }
    func widthOfString(text: String,font : UIFont) -> CGFloat{
        let fontAttributes = [NSAttributedString.Key.font:font]
        let textSize = text.size(withAttributes: fontAttributes)
        return textSize.width
    }
}


