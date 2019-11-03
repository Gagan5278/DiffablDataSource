//
//  CurrencyFindCollectionViewCell.swift
//  DiffablDataSource
//
//  Created by Gagan Vishal on 2019/10/31.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import UIKit

protocol UpdateCurrencyRate {
    func changeCurrencyRate(enteredValue: Double, reuiredEnteredAmount: Double)
}

struct  SelectedCurrencyInfo: Hashable {
    let id : String
    let currenyName: String
    var currrencyValue: Double  //properety need to declare as var.
}

class CurrencyFindCollectionViewCell: UICollectionViewCell, Cell {
    //IBoutlets
    @IBOutlet weak var selectedCurrencyLabel: UILabel!
    @IBOutlet weak var amountTextfield: UITextField!
    //delegate
    var delegate: UpdateCurrencyRate?
    //var to store actual rate of selected currency
    var selectedCurrencyActualRate: Double = 1.0
    //MARK:- View life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK:- Cell protocol
    func config(with Object: SelectedCurrencyInfo) {
        selectedCurrencyLabel.text = Object.currenyName
        amountTextfield.text = "\(Object.currrencyValue)"
        self.selectedCurrencyActualRate = Object.currrencyValue
    }
    
    //MARK:- Button Action
    @IBAction func covertCurrencyButtonClicked(_ sender: Any) {
        //1.
        amountTextfield.resignFirstResponder()
        //2.
        if !amountTextfield.text!.isEmpty, let enterdDoubleAmount = Double(amountTextfield.text!) {
            delegate?.changeCurrencyRate(enteredValue: enterdDoubleAmount*(1.0/self.selectedCurrencyActualRate), reuiredEnteredAmount:enterdDoubleAmount)
        }
    }
    
}

//MARK:- UITextFieldDelegate
extension CurrencyFindCollectionViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let decimalCount = textField.text!.components(separatedBy: ".").count - 1
        if decimalCount > 0 && (string == "." || string == ",") { //Some countries has ,  as '.' decimal points. 
            return false
        }
        return true
    }
}
