//
//  ShowCaseTableViewCell.swift
//  MovieViewImplemenatation
//
//  Created by AungKoKo on 31/01/2021.
//

import UIKit

class ShowCaseTableViewCell: UITableViewCell {

    @IBOutlet weak var captionUnderline: UILabel!
    @IBOutlet weak var showCaseMovieCollectionView: UICollectionView!
    
    @IBOutlet weak var heightOfShowCaseCollectionView: NSLayoutConstraint!
    
    @IBOutlet weak var widthOfSHowCaseCollectionView: NSLayoutConstraint!
    
    var delegate:MovieItemDelegate?
    
    var dataFetchFromViewController:PopularSeries?{
        didSet{
            if let _ = dataFetchFromViewController{
                self.showCaseMovieCollectionView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        showCaseMovieCollectionView.registerCollectionViewCells(identifier: ShowCaseCollectionViewCell.identifier)
        showCaseMovieCollectionView.delegate = self
        showCaseMovieCollectionView.dataSource = self
        captionUnderline.addUnderline(text: "More Showcases")
        setUpHeight()
        onTapLabel()
    }
    
    private func onTapLabel(){
        let gestureRecog = UITapGestureRecognizer(target: self, action: #selector(onTap))
        captionUnderline.addGestureRecognizer(gestureRecog)
        captionUnderline.isUserInteractionEnabled = true
    }
    @objc func onTap(){
        delegate?.onTapMoreShowCase()
    }
    
    func setUpHeight(){
//        self.widthOfSHowCaseCollectionView.constant -= 50
        self.heightOfShowCaseCollectionView.constant = ((self.widthOfSHowCaseCollectionView.constant)/16)*9
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension ShowCaseTableViewCell : UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataFetchFromViewController?.results?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell = collectionView.dequeReusableCells(identifier: ShowCaseCollectionViewCell.identifier, indexPath: indexPath) as? ShowCaseCollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.data = dataFetchFromViewController?.results?[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let idKey = dataFetchFromViewController?.results?[indexPath.row].id ?? 0
        
        delegate?.onTapSeries(idToBind: idKey )
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthItem = showCaseMovieCollectionView.bounds.width-50
        let heightItem = (widthItem/16)*9
        
        return CGSize(width: widthItem, height:heightItem)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        ((scrollView.subviews[(scrollView.subviews.count-1)]).subviews[0]).backgroundColor = UIColor(named: "Color_white")
    }
}
