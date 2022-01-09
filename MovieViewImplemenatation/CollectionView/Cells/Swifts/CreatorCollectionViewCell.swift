//
//  CreatorCollectionViewCell.swift
//  MovieViewImplemenatation
//
//  Created by Aung Ko Ko on 05/07/2021.
//

import UIKit
import SDWebImage

class CreatorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var creatorName: UILabel!
    @IBOutlet weak var backGroundImageView: UIImageView!
    
    var data:PeopleDetail?{
        didSet{
            if let data = data{
                creatorName.text = data.name ?? ""
                let imagePath = data.profilePath ?? ""
                backGroundImageView.sd_setImage(with: URL(string: "\(Constants.baseImageUrl)\(imagePath)"))
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
