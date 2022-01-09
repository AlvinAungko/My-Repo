//
//  TrailerMovieItemCollectionViewCell.swift
//  MovieViewImplemenatation
//
//  Created by Aung Ko Ko on 06/07/2021.
//

import UIKit
import YouTubePlayer

class TrailerMovieItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var youTubePlayer: YouTubePlayerView!
    
    @IBOutlet weak var trailerTitle: UILabel!
    var data:String? {
        didSet{
            if let _ = data{
                youTubePlayer.loadVideoID("\(data ?? "")")
                youTubePlayer.play()
                trailerTitle.text = ""
            } else{
                trailerTitle.text = "Not Available at the Moment."
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Load video from YouTube ID
      

    }

}
