//
//  ProductionCompanyCollectionViewCell.swift
//  MovieViewImplemenatation
//
//  Created by Aung Ko Ko on 01/07/2021.
//

import UIKit
import SDWebImage

class ProductionCompanyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var productionTitle: UILabel!
    
    var data:ProductionCompany?{
        didSet{
            if let data = data{
               
                if let _ = data.logoPath
                {
                let imagePath = data.logoPath ?? ""
                backGroundImage.sd_setImage(with: URL(string: "\(Constants.baseImageUrl)\(imagePath)"))
                    productionTitle.text = ""
                
                }else{
                    productionTitle.text = data.name ?? ""
                }
                

            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
