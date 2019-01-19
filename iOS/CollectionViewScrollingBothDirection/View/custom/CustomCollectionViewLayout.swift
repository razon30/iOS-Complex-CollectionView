//
//  CustomCollectionViewLayout.swift
//  iOS
//
//  Created by Razon Hossain on 1/18/19.
//  Copyright © 2019 razon. All rights reserved.
//

import UIKit

class CustomCollectionViewLayout: UICollectionViewLayout {
    
    let numberOfColumns = 8
    var shouldPinFirstColumn = true
    var shouldPinFirstRow = true
    
    var itemAttributes = [[UICollectionViewLayoutAttributes]]()  // 2D aray for section and row
    var itemSize = [CGSize]()
    var contentSize: CGSize = .zero
    
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return itemAttributes[indexPath.section][indexPath.row]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = [UICollectionViewLayoutAttributes]()
        for section in itemAttributes {
            
            let filteredArray = section.filter { obj-> Bool in
                
                return rect.intersects(obj.frame)
                
            }
            attributes.append(contentsOf: filteredArray)
            
        }
        
        return attributes
        
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true // Set this to true to call prepareLayout on every scroll
    }
    
    override func prepare() {
        
        guard let collectionView = collectionView else {
            return
        }
        
        if collectionView.numberOfSections == 0 {
            return
        }
        
        if itemAttributes.count != collectionView.numberOfSections {
            generateItemAttributes(collectionView)
            return
        }
        
        
        for section in 0..<collectionView.numberOfSections {
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                if section != 0 && item != 0 {
                    continue
                }
                
                let attributes = layoutAttributesForItem(at: IndexPath(item: item, section: section))!
                if section == 0 {
                    var frame = attributes.frame
                    frame.origin.y = collectionView.contentOffset.y
                    attributes.frame = frame
                }
                
                if item == 0 {
                    var frame = attributes.frame
                    frame.origin.x = collectionView.contentOffset.x
                    attributes.frame = frame
                }
            }
        }
        
        
        
    }
    
    func generateItemAttributes(_ collectionView: UICollectionView) {
        
        if itemSize.count != numberOfColumns {
            calculateItemSize()
        }
        
        var column = 0
        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0
        var contentWidth: CGFloat = 0
        
        itemAttributes = []
        
        for section in 0..<collectionView.numberOfSections {
            
            var sectionAttribute: [UICollectionViewLayoutAttributes] = []
            
            for index in 0..<numberOfColumns {
                
                let itemsize = itemSize[index]
                let indexPath = IndexPath(item: index, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(x: xOffset, y: yOffset, width: itemsize.width, height: itemsize.height)
                
                if section == 0 && index == 0 {
                    attributes.zIndex = 1024  // First cell should be on top
                }else if section == 0 || index == 0 {
                    attributes.zIndex = 1023
                }
                
                if section == 0 {
                    
                    var frame = attributes.frame
                    frame.origin.y = collectionView.contentOffset.y
                    attributes.frame = frame
                    
                }
                
                if index == 0 {
                    
                    var frame = attributes.frame
                    frame.origin.x = collectionView.contentOffset.x
                    attributes.frame = frame
                    
                }
                
                sectionAttribute.append(attributes)
                
                xOffset += itemsize.width
                column += 1
                
                if column == numberOfColumns {
                    
                    if xOffset > contentWidth {
                        contentWidth = xOffset
                    }
                    
                    column = 0
                    xOffset = 0
                    yOffset += itemsize.height
                    
                }
                
            }
            itemAttributes.append(sectionAttribute)

        }
        
        if let attributes = itemAttributes.last?.last {
            contentSize = CGSize(width: contentWidth, height: attributes.frame.maxY)
        }
        
    }
    
    func calculateItemSize()  {
        itemSize = []
        
        for index in 0..<numberOfColumns{
            
            itemSize.append(sizeForItemWithColumnIndex(index))
            
        }
        
    }
    
    func sizeForItemWithColumnIndex(_ columnIndex: Int) -> CGSize {
        
        var text: String
        
        switch columnIndex  {
        case 0:
            text = "MMM-99"
        default:
            text = "Content"
        }
        
        let size: CGSize = text.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)])
        let width: CGFloat = size.width + 16
        return CGSize(width: width, height: 30)
        
    }
    

}
