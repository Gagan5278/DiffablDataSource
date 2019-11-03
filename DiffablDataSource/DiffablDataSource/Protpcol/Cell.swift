//
//  Cell.swift
//  DiffablDataSource
//
//  Created by Gagan Vishal on 2019/10/31.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation

protocol Cell {
    associatedtype TObject
    func config(with Object: TObject)
}
