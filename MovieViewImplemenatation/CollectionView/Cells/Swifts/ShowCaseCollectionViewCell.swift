//
//  ShowCaseCollectionViewCell.swift
//  MovieViewImplemenatation
//
//  Created by AungKoKo on 31/01/2021.
//

import UIKit
import SDWebImage

class ShowCaseCollectionViewCell: UICollectionViewCell {

    var data:Series?{
        didSet{
            if let data = data{
                let movieName = data.originalName ?? ""
                let movieReleaseDate = data.firstAirDate ?? ""
                let backPathUrl = data.backdropPath ?? ""
                
                movieTitle.text = movieName
                movieDate.text = movieReleaseDate
                

                backGroundImageView.sd_setImage(with: URL(string: "\(Constants.baseImageUrl)\(backPathUrl)"))

                
            }
        }
    }
    
    
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var backGroundImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
