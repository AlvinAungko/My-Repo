//
//  BestSeriesCollectionViewCell.swift
//  MovieViewImplemenatation
//
//  Created by Aung Ko Ko on 27/06/2021.
//

import UIKit
import SDWebImage

class BestSeriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainMovieLabel: UILabel!
    @IBOutlet weak var customRating: RatingControl_StackView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var backGroundImage: UIImageView!
    
    var data:Series?{
        didSet {
            if let data = data{
                let imageUrl = "\(Constants.baseImageUrl)\(data.backdropPath ?? "No Url for Image")"
                let movieLabel = data.name
                 
                mainMovieLabel.text = movieLabel
                backGroundImage.sd_setImage(with: URL(string: imageUrl))
                customRating.rating = Int(data.voteAverage ?? 0.0)/2
                ratingLabel.text = String(data.voteAverage ?? 0.0)
                
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
