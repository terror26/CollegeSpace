//
//  RoundButton.swift
//  CollegeSpace
//
//  Created by Kanishk Verma on 18/01/18.
//  Copyright © 2018 Kanishk Verma. All rights reserved.
//

import UIKit

class RoundButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(red: CGFloat(Constants.Shadow_Color), green: CGFloat(Constants.Shadow_Color), blue: CGFloat(Constants.Shadow_Color), alpha: 1.0).cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.8
        imageView?.contentMode = .scaleAspectFit
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.height/2 ;
        
    }
}
