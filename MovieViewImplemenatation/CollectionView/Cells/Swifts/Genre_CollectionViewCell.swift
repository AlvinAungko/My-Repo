//
//  Genre_CollectionViewCell.swift
//  MovieViewImplemenatation
//
//  Created by AungKoKo on 30/01/2021.
//

import UIKit

class Genre_CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lbl_Caption: UILabel!
    @IBOutlet weak var viewForOverlay: UIView!
    
    var onTap :((Int) -> Void) = {_ in}
    
    
    
    
    var data:GenreVo? = nil{
        didSet{
            if let genre = data{
                lbl_Caption.text = genre.name
                (genre.isSelected) ? (viewForOverlay.isHidden = false) : (viewForOverlay.isHidden = true)
               
                
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let guestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addRecogToView))
        containerView.addGestureRecognizer(guestureRecognizer)
        containerView.isUserInteractionEnabled = true
    }
    @objc func addRecogToView(){
        onTap(data?.id ?? 0)
    }

}
