//
//  ViewController.swift
//  DiffablDataSource
//
//  Created by Gagan Vishal on 2019/10/29.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //IBOutlets
    @IBOutlet weak var currencyCollectionView: UICollectionView!
    //View Model Objcet
    let viewModel: CurrencyListViewModel = CurrencyListViewModel()
    //Adapter
    lazy var adapter = CollectionAdapter(collectionView: currencyCollectionView, delegate: self)
    var selectedCurrency = SelectedCurrencyInfo(id:UUID().uuidString, currenyName: "USD", currrencyValue: 1.0)
    //Message to display on cell if there is some issue from server side
    var errorOrEmptyStateMessage = String()
    //Activity Indicator
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        self.view.addSubview(activity)
        activity.center = self.view.center
        activity.hidesWhenStopped = true
        return activity
    }()
    //store prvious selected row index
    var previousSelectedIndex: Int = -1
    //1.0 is default for USD
    var selectedExchangeRate: Double = 1.0
    //MARK:- View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorSetup()
        bindViewModel()
        viewModel.getAllCurrenciesAndExchangeRates()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    //MARK:- Add activity indicator on view
    fileprivate func activityIndicatorSetup() {
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.center = self.view.center
    }
    
    //MARK:- Bind View Model
    private func bindViewModel() {
        viewModel.currencies.bindAndFire() { [weak self] (items) in
            if !items.isEmpty {
                DispatchQueue.main.async { [weak self] in
                    self?.adapter.performUpdate {
                        print("Adapter perform refresh of collection")
                    }
                }
            }
        }
        viewModel.showLoadingHud.bind() {  visible in
            DispatchQueue.main.async { [weak self] in
                if visible == false   //If visible the hide
                {
                    self?.activityIndicator.stopAnimating()
                }
                else
                {
                    self?.activityIndicator.startAnimating()
                }
            }
        }
    }
    
    //MARK:- Did select currency
    private func didSelect(exchnage: ExchangeRate, at index: Int, cell: UICollectionViewCell) {
        //1.
        ExchangeRate.updatedcalculatedRate = 1.0
        //2.
        if exchnage.fxPair == selectedCurrency.currenyName {
            viewModel.exchangeRates[index].isSelectedItem = false
            selectedCurrency = SelectedCurrencyInfo(id:UUID().uuidString, currenyName: "USD", currrencyValue: 1.0)
        }
        else {
            if previousSelectedIndex >= 0 {
                viewModel.exchangeRates[previousSelectedIndex].isSelectedItem = false
            }
            viewModel.exchangeRates[index].isSelectedItem = true
            selectedCurrency = SelectedCurrencyInfo(id:UUID().uuidString, currenyName: exchnage.fxPair, currrencyValue: exchnage.rate*selectedExchangeRate)
        }
        //3.
        CurrencyFindCollectionViewCell.selectedCurrencyActualRate = exchnage.currencyActualRate
        //4.
        previousSelectedIndex = index
        //5.
        adapter.performUpdate{
            //Uncomment below if need auto scroll to top
//            self.currencyCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0),at: .top,animated: true)
        }
    }
}

//MARK:- CollectionAdapterDelegate
extension ViewController: CollectionAdapterDelegate {
    func sectoins() -> [Section] {
        //1.
        let selectedCurrencySection = CollectionViewSection<SelectedCurrencyInfo, CurrencyFindCollectionViewCell>(id: CollecetionSections.selectedCurrencySection.rawValue)
        selectedCurrencySection.cellLayout = { env in
            return NSCollectionLayoutSection.listLayout(envoironment: env, height: .fractionalHeight(1.0))
        }
        //2.
        
        let item = viewModel.currencies.value[0]
        switch item {
        case .normal(_):
            //1.
            let selectedCurrencySection = CollectionViewSection<SelectedCurrencyInfo, CurrencyFindCollectionViewCell>(id: CollecetionSections.selectedCurrencySection.rawValue)
            selectedCurrencySection.cellLayout = { env in
                return NSCollectionLayoutSection.listLayout(envoironment: env, height: .absolute(60.0))
            }
            selectedCurrencySection.cellConfiguration = { cell in
                cell.delegate = self
            }
            //2.
            let currencySection = CollectionViewSection<ExchangeRate, CurrencyCollectionViewCell>(id: CollecetionSections.allCurrenciesSection.rawValue)
            currencySection.cellLayout = { env in
                return NSCollectionLayoutSection.gridLayput(envoirnment: env, height: .absolute(110.0), compactItems: 3, regularItems: 5)
            }
            currencySection.cellSelection = { [weak self] (item, index, cell) in
                self?.didSelect(exchnage: item, at: index, cell: cell)
            }
            return [selectedCurrencySection, currencySection]
        case .empty:
            self.errorOrEmptyStateMessage = Constants.emptyStateMessage
        case .error(_):
            self.errorOrEmptyStateMessage = Constants.errorStateMessage
        }
        //3.
        let errorOrEmptyCell = CollectionViewSection<EmptyOrEErrorMessage, EmptyCollectionViewCell>(id: CollecetionSections.emptyOrError.rawValue)
        errorOrEmptyCell.cellLayout = { env in
            return NSCollectionLayoutSection.listLayout(envoironment: env, height: .fractionalHeight(1.0))
        }
        return [errorOrEmptyCell]
    }
    
    func item(for section: Section) -> [AnyHashable] {
        switch section {
        case is CollectionViewSection<SelectedCurrencyInfo, CurrencyFindCollectionViewCell>:
            return [selectedCurrency]
        case is CollectionViewSection<ExchangeRate, CurrencyCollectionViewCell>:
            return viewModel.exchangeRates
        case is CollectionViewSection<EmptyOrEErrorMessage, EmptyCollectionViewCell>:
            return [EmptyOrEErrorMessage(id: UUID().uuidString, messageString: self.errorOrEmptyStateMessage)]
        default:
            return []
        }
    }
}

//MARK:- View Controller extension
extension ViewController {
    enum CollecetionSections: String {
        case selectedCurrencySection
        case allCurrenciesSection
        case emptyOrError
    }
}

//MARK:- UpdateCurrencyRate
extension ViewController: UpdateCurrencyRate {
    func changeCurrencyRate(enteredValue: Double, reuiredEnteredAmount: Double) {
        ExchangeRate.updatedcalculatedRate = enteredValue
        selectedCurrency.currrencyValue = reuiredEnteredAmount
        adapter.performUpdate(updateFirstSection: false)
    
    }
}
