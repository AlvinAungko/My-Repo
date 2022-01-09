//
//  RatingControl_StackView.swift
//  MovieViewImplemenatation
//
//  Created by AungKoKo on 26/01/2021.
//

import UIKit

 @IBDesignable class RatingControl_StackView: UIStackView {
    
  @IBInspectable var rating: Int = 4
  {
    didSet{
        setUpButtons()
        updateRatingButtons()
    }
  }
    @IBInspectable var starCount: Int = 5{
        didSet{
            setUpButtons()
            updateRatingButtons()
        }
    }
       
    @IBInspectable var starSize : CGSize = CGSize(width: 20, height: 20){
        didSet{
            setUpButtons()
            updateRatingButtons()
        }
    }

    
    var ratingButtons = [UIButton]()

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setUpButtons()
//        updateRatingButtons()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
//        setUpButtons()
//        updateRatingButtons()
    }
    
    private func setUpButtons(){
        clearExistingButton()
        for _ in 0..<starCount{
            
        let button = UIButton()
            
        button.setImage(UIImage(named: "empty_Star"), for: .normal)
        button.setImage(UIImage(named: "fill_Star"), for: .selected)
       
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
        
        addArrangedSubview(button)
        ratingButtons.append(button)
        }
    }
    private func updateRatingButtons(){
        for(index,button) in ratingButtons.enumerated(){
            button.isSelected = index < rating
        }
    }
    private func clearExistingButton(){
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
    }

}
