//
//  Constants.swift
//  DiffablDataSource
//
//  Created by Gagan Vishal on 2019/10/29.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
import UIKit

public enum Constants {
     static let access_key = "adef4294c8e65659aad3e47942dd546a"
    
    //
    static let emptyStateMessage = "Currencies exchnage rates are not availbale."
    static let errorStateMessage = "Something went wrong. Please try again later."
}

class Helper {

    class func createAttributedString(titleString: String, subTitleString: String, titleFont: UIFont,titleTextColor: UIColor, subTitleFont: UIFont, subTitleTextColor: UIColor) -> NSAttributedString
    {
        //1.
        let accountHeaderAttributes = [
            NSAttributedString.Key.foregroundColor : titleTextColor as Any,
            NSAttributedString.Key.font : titleFont as Any,
        ]
        //2.
        let accountBalanceAttributes = [
            NSAttributedString.Key.foregroundColor : subTitleTextColor  as Any,
            NSAttributedString.Key.font : subTitleFont  as Any,
            ] as [NSAttributedString.Key : Any]
        
        //3.
        let firstAttrString = NSAttributedString(string: titleString, attributes: accountHeaderAttributes)
        //4.
        let secondAttrString = NSMutableAttributedString(string: subTitleString, attributes: accountBalanceAttributes)
        //5.
        let combination = NSMutableAttributedString()
        combination.append(firstAttrString)
        combination.append(secondAttrString)
        return combination
    }
}
