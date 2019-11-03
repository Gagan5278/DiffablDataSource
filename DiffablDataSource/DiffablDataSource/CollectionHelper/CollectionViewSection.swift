//
//  CollectionViewSection.swift
//  DiffablDataSource
//
//  Created by Gagan Vishal on 2019/10/31.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
import UIKit


class CollectionViewSection<T: Hashable, CollectionCell: Cell>: Section where CollectionCell: UICollectionViewCell, CollectionCell.TObject == T {
    //1. Layout for cell
    var cellLayout: ((NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection)?
    //2.cell selection
    var cellSelection: ((T, Int, UICollectionViewCell) -> Void)?
    //
    var cellConfiguration: ((CollectionCell) -> Void)?
    //3. Unique id for cell registration
    var cellIDString: String {
        return String(describing: CollectionCell.self)
    }
    
    //MARK:- register cell in collectionview
    override func registerCell(with collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: self.cellIDString, bundle: .main), forCellWithReuseIdentifier: self.cellIDString)
    }
    
    //MARK:- Finf cell at index path
    override func cell(for item: AnyHashable, indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell? {
        guard let itemCell = item as? T else {
            return nil
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIDString, for: indexPath) as? CollectionCell else {
            return nil
        }
        //1.
        cell.config(with: itemCell)
        //2.
        cellConfiguration?(cell)
        return cell
    }
    
    //MARK:- Layout for cell
    override func layout(in envoirnment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        return cellLayout?(envoirnment)
    }
    
    //MARK:- Cell Selection
    override func didSelect(item: AnyHashable, at indexPath: IndexPath, cell: UICollectionViewCell) {
        guard let itemCell = item as? T else {
            return
        }
        cellSelection?(itemCell, indexPath.row, cell)
    }

}
