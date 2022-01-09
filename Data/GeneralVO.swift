//
//  GeneralVO.swift
//  MovieViewImplemenatation
//
//  Created by AungKoKo on 30/01/2021.
//

import Foundation

class GenreVo{
    var name:String = "Hi"
    var isSelected : Bool = false
    var id:Int

    
    init (name:String,isSelected:Bool,idForCell:Int) {
        self.name = name
        self.isSelected = isSelected
        self.id = idForCell
    }
}
