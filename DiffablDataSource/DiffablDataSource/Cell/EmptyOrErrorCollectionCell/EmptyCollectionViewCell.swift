//
//  EmptyCollectionViewCell.swift
//  DiffablDataSource
//
//  Created by Gagan Vishal on 2019/11/01.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import UIKit

struct  EmptyOrEErrorMessage: Hashable {
    let id : String
    let messageString: String
}

class EmptyCollectionViewCell: UICollectionViewCell, Cell {


    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func config(with Object: EmptyOrEErrorMessage) {
        self.messageLabel.text = Object.messageString
    }
}
