//
//  CollectionAdapterDelegate.swift
//  DiffablDataSource
//
//  Created by Gagan Vishal on 2019/10/31.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation

protocol  CollectionAdapterDelegate: AnyObject {
  func sectoins() -> [Section]
    func item(for section: Section) -> [AnyHashable]
}
