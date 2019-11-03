//
//  Section.swift
//  DiffablDataSource
//
//  Created by Gagan Vishal on 2019/10/31.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
import UIKit
class Section: Hashable {

    let id:  String
    
    init(id: String) {
        self.id = id
    }
    //MARK:- Register cell inside section
    func registerCell(with collectionView: UICollectionView) {
        
    }
    
    //MARK:- Cell for item in section
    func cell(for item: AnyHashable, indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell? {
        return nil
    }
    
    //MARK:- lay for cell
    func layout(in envoirnment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection?
    {
        return nil
    }

    //MARK:- Cell selection
    func didSelect(item: AnyHashable, at indexPath: IndexPath, cell: UICollectionViewCell)
    {
        
    }
    
    //MARK: Hashable protcols
    static func == (lhs: Section, rhs: Section) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
