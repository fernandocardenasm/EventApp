//
//  HomeCell.swift
//  EventApp
//
//  Created by Fernando on 24.04.18.
//  Copyright © 2018 Fernando. All rights reserved.
//

import Foundation
import UIKit

class HomeCell: BaseCell {
    
    var homeOption: HomeOption? {
        didSet {
            if let imageString = homeOption?.imageURL {
                imageOption.image = UIImage(named: imageString)
                imageOption.image = imageOption.image?.withRenderingMode(.alwaysTemplate)
                imageOption.tintColor = .white
                
            }
            if let labelString = homeOption?.text {
                labelOption.text = labelString
            }
        }
    }
    
    var imageOption: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        return iv
    }()
    
    var labelOption: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.text = "Program"
        return label
    }()
    
    override func setUpViews() {
        addSubview(imageOption)
        addSubview(labelOption)
        
        addConstrainstWithFormat("H:|-10-[v0(60)]-10-[v1]|", views: imageOption, labelOption)
        addConstrainstWithFormat("V:|[v0]|", views: imageOption)
        addConstrainstWithFormat("V:|[v0]|", views: labelOption)
        
    }
    
}
