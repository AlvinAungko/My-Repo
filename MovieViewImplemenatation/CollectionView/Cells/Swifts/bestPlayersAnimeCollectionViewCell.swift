//
//  bestPlayersAnimeCollectionViewCell.swift
//  MovieViewImplemenatation
//
//  Created by AungKoKo on 03/02/2021.
//

import UIKit
import SDWebImage

class bestPlayersAnimeCollectionViewCell: UICollectionViewCell {
    var delegate:ActorActionDelegate?=nil
    @IBOutlet weak var ivHeart: UIImageView!
    @IBOutlet weak var ivHeartFill: UIImageView!
    @IBOutlet weak var backGroundImageView: UIImageView!
    
    @IBOutlet weak var whatIsHeFamousFor: UILabel!
    @IBOutlet weak var castName: UILabel!
    
     var data:PeopleDetail?{
        didSet{
            if let data = data{
                castName.text = data.name ?? ""
                whatIsHeFamousFor.text = data.knownForDepartment ?? ""
                let imagePath = data.profilePath ?? "Nil"
                backGroundImageView.sd_setImage(with: URL(string: "\(Constants.baseImageUrl)\(imagePath)"))
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tapGuesture()
    }
    private func tapGuesture(){
    
        let tapguestureForHeart = UITapGestureRecognizer(target: self, action: #selector(tapOniVHeart))
        ivHeart.addGestureRecognizer(tapguestureForHeart)
        ivHeart.isUserInteractionEnabled = true
        
        let tapGuestureForHeartFill = UITapGestureRecognizer(target: self, action: #selector(tapOniVHeartFill))
        ivHeartFill.addGestureRecognizer(tapGuestureForHeartFill)
        ivHeartFill.isUserInteractionEnabled = true
        
    }
    @objc func tapOniVHeart(){
        delegate?.onTap(isHidden: false)
        ivHeart.isHidden = true
        ivHeartFill.isHidden = false
        
    }
    @objc func tapOniVHeartFill(){
        delegate?.onTap(isHidden: true)
        ivHeart.isHidden = false
        ivHeartFill.isHidden = true
       
    }
}


    
  

