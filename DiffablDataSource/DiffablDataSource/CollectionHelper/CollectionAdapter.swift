//
//  CollectionAdapter.swift
//  DiffablDataSource
//
//  Created by Gagan Vishal on 2019/10/31.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
import UIKit
class CollectionAdapter: NSObject {
    private weak var collectionView: UICollectionView?
    private lazy var datasource: UICollectionViewDiffableDataSource<Section, AnyHashable> = UICollectionViewDiffableDataSource(collectionView: self.collectionView!, cellProvider: cell)
    private weak var delegate: CollectionAdapterDelegate?
    
    //MARK: Init
    init(collectionView: UICollectionView, delegate: CollectionAdapterDelegate) {
        self.collectionView = collectionView
        self.delegate = delegate
        super.init()
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: sectionLayout(for:enoironment:))
    }
    
    //MARK: Get cell
    private func cell(in collection: UICollectionView, at indexPath: IndexPath, for item: AnyHashable) -> UICollectionViewCell? {
        guard let item = datasource.itemIdentifier(for: indexPath) else {
            return nil
        }
        let section = datasource.snapshot().sectionIdentifiers[indexPath.section]
        return section.cell(for: item, indexPath: indexPath, in: collection)
    }
    
    //MARK: Layout
    private func sectionLayout(for sectionIndex: Int, enoironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        let section = datasource.snapshot().sectionIdentifiers[sectionIndex]
        return section.layout(in: enoironment)
    }
    
    private func sectionLayout(for sectionIndex: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        let section = datasource.snapshot().sectionIdentifiers[sectionIndex]
        return section.layout(in: environment)
    }

    //MARK:- Update datasource
    func performUpdate(animated: Bool = true, updateFirstSection: Bool = true, completionHandler: (() -> Void)? = nil) {
        guard let delegate = delegate, let collection = collectionView else {
            return
        }
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        for section in delegate.sectoins() {
            section.registerCell(with: collection)
            snapshot.appendSections([section])
            let items = delegate.item(for: section)
            snapshot.appendItems(items)
        }
        datasource.apply(snapshot, animatingDifferences: animated, completion: completionHandler)
    }
}

//MARK:- UICollectionView Delegate
extension CollectionAdapter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedItem = self.datasource.itemIdentifier(for: indexPath), let cellSelected = cell(in: collectionView, at: indexPath, for: selectedItem) else {
            return
        }
        let section = self.datasource.snapshot().sectionIdentifiers[indexPath.section]
        section.didSelect(item: selectedItem, at: indexPath, cell: cellSelected)
    }
}
