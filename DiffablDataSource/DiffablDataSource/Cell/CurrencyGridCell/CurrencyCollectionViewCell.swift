//
//  CurrencyCollectionViewCell.swift
//  DiffablDataSource
//
//  Created by Gagan Vishal on 2019/11/01.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import UIKit

class CurrencyCollectionViewCell: UICollectionViewCell, Cell {
    //IBOutlets
    @IBOutlet weak var checkMarkImageView: UIImageView!
    @IBOutlet weak var currencySymbleLabel: UILabel!
    @IBOutlet weak var currencyRateLabel: UILabel!
    //MARK:- View life cyccle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let view = self.viewWithTag(10) {
            view.layer.configureGradientBackground(UIColor.purple.cgColor, UIColor.blue.cgColor, UIColor.white.cgColor)
        }
    }

    //MARK:- Cell protocol for cell config
    func config(with Object: ExchangeRate) {
        currencySymbleLabel.text = Object.currencyName
        currencyRateLabel.attributedText = Helper.createAttributedString(titleString: Object.getSymbolForCurrencyCode ?? Object.currencyName.lowercased(), subTitleString: String(format: "%.2f",Object.getCurrencyRate), titleFont: UIFont(name: "American Typewriter", size: 20.0)!, titleTextColor: .white, subTitleFont: UIFont(name: "American Typewriter", size: 16.0)!, subTitleTextColor: .white)
        checkMarkImageView.isHidden = !Object.isSelectedItem
    }

}
