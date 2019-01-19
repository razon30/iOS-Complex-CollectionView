//
//  CollectionViewCell.swift
//  iOS
//
//  Created by Razon Hossain on 1/18/19.
//  Copyright © 2019 razon. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let label: UILabel = {
        
       var label = UILabel(frame: .zero)
//        label.textColor = UIColor.black
//        label.layoutMargins.bottom = 8
//        label.layoutMargins.top = 8
//        label.layoutMargins.left = 8
//        label.layoutMargins.right = 8
        return label
        
    }()
    
    
    var labelValue: String? {
        
        didSet{
            
            label.text = labelValue
            
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        //self.setLabel
    }
    
    
}
