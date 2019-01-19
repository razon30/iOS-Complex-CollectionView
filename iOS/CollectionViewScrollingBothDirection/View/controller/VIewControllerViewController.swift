//
//  VIewControllerViewController.swift
//  iOS
//
//  Created by Razon Hossain on 1/18/19.
//  Copyright © 2019 razon. All rights reserved.
//

import UIKit

class VIewControllerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    let collectionViewCellIdentifier = "ContentCellIdentifier"
    
    lazy var collectionView: UICollectionView = {
    
        let collectionviewLayout = CustomCollectionViewLayout()
       var cv = UICollectionView(frame: .zero, collectionViewLayout: collectionviewLayout)
        cv.isScrollEnabled = true
        cv.isDirectionalLockEnabled = true
        cv.dataSource = self
        cv.delegate = self
        return cv
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: collectionViewCellIdentifier)
        
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier, for: indexPath) as! CollectionViewCell
        
        if indexPath.section % 2 != 0 {
            cell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.labelValue = "Date"
            } else {
                cell.labelValue = "Section"
            }
        } else {
            if indexPath.row == 0 {
                cell.labelValue = String(indexPath.section)
            } else {
                cell.labelValue = "Content"
            }
        }
    
        return cell
        
    }

}
