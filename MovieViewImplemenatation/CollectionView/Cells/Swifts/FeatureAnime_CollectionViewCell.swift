//
//  FeatureAnime_CollectionViewCell.swift
//  MovieViewImplemenatation
//
//  Created by AungKoKo on 26/01/2021.
//

import UIKit
import SDWebImage

class FeatureAnime_CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelTextForrRating: UILabel!
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var myCustomStackView: RatingControl_StackView!
    @IBOutlet weak var mainTitleName: UILabel!
    
    
    var
        
        data:Result?{
        didSet{
            if let data = data{
                let movieText = data.originalTitle ?? "Empty"
              
                let backImagePath = "\(Constants.baseImageUrl)\(data.backdropPath ?? "No url has been Passed.")"
                let ratingControlCount = Int(data.voteAverage ?? 0.0)
                let actualRating = ratingControlCount/2
                
                mainTitleName.text = movieText
                myCustomStackView.rating = actualRating
                backGroundImage.sd_setImage(with: URL(string: backImagePath))
                labelTextForrRating.text = String(data.voteAverage ?? 0.0)
            }
        }
    }
    
    var dataFromSeries:Series?{
        didSet{
            if let data = dataFromSeries{
                let seriesName = data.name
                let backPath = "\(Constants.baseImageUrl)\(data.backdropPath ?? "No Image Url")"
                let voteAvergae = Int(data.voteAverage ?? 0.0)/2
                
                mainTitleName.text = seriesName
                backGroundImage.sd_setImage(with: URL(string: backPath))
                myCustomStackView.rating = voteAvergae
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

}
