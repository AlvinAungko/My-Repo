//
//  MovieSliderCollectionViewCell.swift
//  MovieViewImplemenatation
//
//  Created by AungKoKo on 24/01/2021.
//

import UIKit
import SDWebImage

class MovieSliderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var data:Result?
    {
        didSet {
            if let data = data{
            let textLabel = data.originalTitle
                
                let backGroundImage = "\(Constants.baseImageUrl)\(data.backdropPath ?? "nil")"
//                debugPrint(data.backdropPath ?? "")
                mainLabel.text = textLabel
//                debugPrint(mainLabel.text ?? "")
                backgroundImage.sd_setImage(with: URL(string: backGroundImage))

            }
        }
    }
    
    
    
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
