//
//  LabelExtension.swift
//  MovieViewImplemenatation
//
//  Created by AungKoKo on 31/01/2021.
//

import Foundation
import UIKit

extension UILabel{
    
    func addUnderline(text:String){
        let attributedString = NSMutableAttributedString.init(string:text)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: _NSRange.init(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }
}

extension NSMutableData {
   func append(_ string: String) {
    let data = string.data(
        using: String.Encoding.utf8,
        allowLossyConversion: true)
    append(data!)
  }
}

