//
//  FilterScreen.swift
//  TechnicalTest

import UIKit

protocol FilterAppyDelegate {
    
    func filterDevices(arrFilter : [String])
}

class FilterScreen: UIViewController {
    
    var tblFilterOption: UITableView!
    private var filterViewModel : FilterViewModel!
    private var dataSource : FilterOptionView<FilterCell,FilterModel>!
    
    var delegate : FilterAppyDelegate!
    
    var arrSaveFilter : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("Filter", comment:"")
        self.view.backgroundColor = UIColor.white
        setNavigationButton()
        setListView()
        
        
    }
}

extension FilterScreen {
    
    //Set Navigation Button
    func setNavigationButton(){
        
        let btnFilter = UIButton(type: .custom)
        btnFilter.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnFilter.setTitle(NSLocalizedString("Apply", comment:""), for: .normal)
        btnFilter.setTitleColor(UIColor.blue, for: .normal)
        btnFilter.addTarget(self, action: #selector(clickOnApply(_:)), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btnFilter)
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
    }
    
    //Set List
    func setListView(){
        
        let navHeight: CGFloat = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let tblWidth: CGFloat = self.view.frame.width
        let tblHeight: CGFloat = self.view.frame.height
        
        tblFilterOption = UITableView(frame: CGRect(x: 0, y: navHeight, width: tblWidth, height: tblHeight - navHeight))
        tblFilterOption.register(FilterCell.self)
        self.view.addSubview(tblFilterOption)
        callToViewModelForUIUpdate()
        tblFilterOption.tableFooterView = UIView()
    }
}

extension FilterScreen {
    
    //ViewModelUIUpdate
    func callToViewModelForUIUpdate(){
        
        self.filterViewModel =  FilterViewModel()
        
        self.arrSaveFilter = UtilsClass.sharedInstance.getMyUserDefaults(key: MyUserDefaultsKey.saveFilter) as! [String]
        if self.arrSaveFilter.count > 0 {
            
            for (_,objFilter) in self.arrSaveFilter.enumerated() {
                
                for (iIndex,item) in self.filterViewModel.arrFilterOption.enumerated() {
                    
                    if objFilter == item.productType {
                        
                        self.filterViewModel.arrFilterOption[iIndex].isSelected = true
                    }
                }
            }
        }
        
        self.updateDataSource()
    }
    
    //Update Device List
    func updateDataSource(){
        
        self.dataSource = FilterOptionView(cellIdentifier: "", items: self.filterViewModel.arrFilterOption, configureCell: { (cell, evm) in
            
            cell.setup(title: evm.productType, isSelect: evm.isSelected)
            cell.viewContainer.tag = evm.index ?? 0
            cell.viewContainer.addTarget(self, action: #selector(self.clickOnFilter(_:)), for: .touchUpInside)
        })
        
        DispatchQueue.main.async {
            self.tblFilterOption.dataSource = self.dataSource
            self.tblFilterOption.reloadData()
        }
    }
}

extension FilterScreen {
    
    //Filter Button Click
    @objc func clickOnFilter(_ sender : UIControl) {
        
        if  self.filterViewModel.arrFilterOption[sender.tag].isSelected ?? false {
            
            self.filterViewModel.arrFilterOption[sender.tag].isSelected = false
        }else {
            self.filterViewModel.arrFilterOption[sender.tag].isSelected = true
        }
        
        self.dataSource = FilterOptionView(cellIdentifier: "", items: self.filterViewModel.arrFilterOption, configureCell: { (cell, evm) in
            
            cell.setup(title: evm.productType, isSelect: evm.isSelected)
        })
        
        DispatchQueue.main.async {
            self.tblFilterOption.dataSource = self.dataSource
            self.tblFilterOption.reloadData()
        }
    }
    
    //Filter Button Click
    @objc func clickOnApply(_ sender : UIButton) {
        
        var arrFilterOption : [String] = []
        if self.filterViewModel.arrFilterOption.count > 0 {
            
            for objFilter in self.filterViewModel.arrFilterOption {
                
                if objFilter.isSelected ?? false {
                    arrFilterOption.append(objFilter.productType!)
                }
            }
        }
        delegate.filterDevices(arrFilter: arrFilterOption)
    }
}
