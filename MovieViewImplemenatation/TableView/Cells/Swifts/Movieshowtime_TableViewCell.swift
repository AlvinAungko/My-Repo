//
//  Movieshowtime_TableViewCell.swift
//  MovieViewImplemenatation
//
//  Created by AungKoKo on 30/01/2021.
//

import UIKit

class Movieshowtime_TableViewCell: UITableViewCell {

    @IBOutlet weak var seeMore_Caption: UILabel!
    @IBOutlet weak var backGround_View: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        backgroundView?.layer.cornerRadius = 10
//        let attributedString = NSMutableAttributedString.init(string: "SEE MORE")
//        attributedString.addAttribute(NSMutableAttributedString.Key.underlineStyle, value: 2, range: _NSRange.init(location: 0, length: attributedString.length))
//        seeMore_Caption.attributedText = attributedString
        seeMore_Caption.addUnderline(text: "SEE MORE")
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
