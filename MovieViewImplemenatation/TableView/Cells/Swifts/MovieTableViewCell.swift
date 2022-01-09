//
//  MovieTableViewCell.swift
//  MovieViewImplemenatation
//
//  Created by AungKoKo on 24/01/2021.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

  
    var delegate:MovieItemDelegate?=nil
    
    var itemDelegate:(MovieItemDelegate)->Void = {_ in}
    
    var data:UpcomingMovie?{
        didSet{
            if let _ = data {
            pageControl.numberOfPages = data?.results?.count ?? 0
            collectionViewMovie.reloadData()
            }
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionViewMovie: UICollectionView!
    override func awakeFromNib() {
        
        collectionViewMovie.showsHorizontalScrollIndicator = false
        super.awakeFromNib()
        collectionViewMovie.registerCollectionViewCells(identifier: MovieSliderCollectionViewCell.identifier)
        
        collectionViewMovie.dataSource = self
        collectionViewMovie.delegate = self
       
     
        pageControl.pageIndicatorTintColor = .white
        pageControl.isHidden = false
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MovieTableViewCell : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var returnCount = Int()
        
        if let data = data{
            returnCount = data.results?.count ?? 0
        }
        
        return returnCount
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeReusableCells(identifier: MovieSliderCollectionViewCell.identifier, indexPath: indexPath) as? MovieSliderCollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.data = self.data?.results?[indexPath.row]
        
        return cell
     
       
//        return collectionViewMovie.dequeReusableCells(identifier: MovieSliderCollectionViewCell.identifier, indexPath: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewMovie.frame.width, height: CGFloat(240))
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let idFromASpecificMovie = data?.results?[indexPath.row].id ?? 0
        
        delegate?.onTapMovie(iDToBind: idFromASpecificMovie)
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    
    }
 
}
