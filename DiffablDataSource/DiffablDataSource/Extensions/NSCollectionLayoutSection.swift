//
//  NSCollectionLayoutSection.swift
//  DiffablDataSource
//
//  Created by Gagan Vishal on 2019/11/01.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
import UIKit

extension NSCollectionLayoutSection {
    //MARK:- Layout to show selected currency
    static func listLayout(envoironment: NSCollectionLayoutEnvironment, height: NSCollectionLayoutDimension) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: height)
        let sectionItem = NSCollectionLayoutItem(layoutSize: itemSize)
        //2. Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: height)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,  subitems: [sectionItem])
        return NSCollectionLayoutSection(group: group)
    }
    
    //MARK:- Grid layout for currencies
    static func gridLayput(envoirnment: NSCollectionLayoutEnvironment, height: NSCollectionLayoutDimension, compactItems: Int, regularItems: Int ) -> NSCollectionLayoutSection {
        //1. Item size
        let itemSize: NSCollectionLayoutSize
        let itemsCount: Int = envoirnment.traitCollection.horizontalSizeClass == .compact ? compactItems : regularItems
        if height.isEstimated {
            itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/CGFloat(itemsCount)), heightDimension: height)
        }
        else {
            itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/CGFloat(itemsCount)), heightDimension: .fractionalHeight(1.0))
        }
        //2. Section Item
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //2. Group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: height), subitem: item, count: itemsCount)
        //3.
        return NSCollectionLayoutSection(group: group)
        
    }
}
