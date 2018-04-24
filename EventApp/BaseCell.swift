//
//  BaseCell.swift
//  EventApp
//
//  Created by Fernando on 24.04.18.
//  Copyright © 2018 Fernando. All rights reserved.
//

import UIKit

open class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    func setUpViews(){
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

