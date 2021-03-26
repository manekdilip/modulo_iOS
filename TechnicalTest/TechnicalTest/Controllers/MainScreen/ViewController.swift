//
//  ViewController.swift
//  TechnicalTest

import UIKit
import SystemConfiguration

class ViewController: UIViewController {
    
    var tblDevices: UITableView!
    
    private var deviceViewModel : DeviceViewModel!
    private var dataSource : DeviceListView<DeviceListCell,Device>!
    var arrDevices : [Device] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("Device List", comment: "")
        setNavigationButton()
        self.setListView()
    }
}

extension ViewController {
    
    //Set Navigation Button
    func setNavigationButton(){
        
        let btnFilter = UIButton(type: .custom)
        btnFilter.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnFilter.setTitle(NSLocalizedString("Filter", comment: ""), for: .normal)
        btnFilter.setTitleColor(UIColor.blue, for: .normal)
        btnFilter.addTarget(self, action: #selector(clickOnFilter(_:)), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btnFilter)
        
        let btnRefresh = UIButton(type: .custom)
        btnRefresh.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnRefresh.setTitle(NSLocalizedString("Refresh", comment: ""), for: .normal)
        btnRefresh.setTitleColor(UIColor.blue, for: .normal)
        btnRefresh.addTarget(self, action: #selector(clickOnRefresh(_:)), for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: btnRefresh)
        
        self.navigationItem.setRightBarButtonItems([item1,item2], animated: true)
    }
    
    //Set List
    func setListView(){
        
        let navHeight: CGFloat = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let tblWidth: CGFloat = self.view.frame.width
        let tblHeight: CGFloat = self.view.frame.height
        
        tblDevices = UITableView(frame: CGRect(x: 0, y: navHeight, width: tblWidth, height: tblHeight - navHeight))
        tblDevices.register(DeviceListCell.self)
        self.view.addSubview(tblDevices)
        
        tblDevices.tableFooterView = UIView()
        
        callToViewModelForUIUpdate()
    }
    
    
}

//HeaderView Button Click Event
extension ViewController {
    
    //Filter Button Click
    @objc func clickOnFilter(_ sender : UIButton) {
        
        let objFilterScreen = FilterScreen()
        objFilterScreen.delegate = self
        let navigationController = UINavigationController(rootViewController: objFilterScreen)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    //Refresh Button Click
    @objc func clickOnRefresh(_ sender : UIButton) {
        
        callToViewModelForUIUpdate()
    }
}


extension ViewController {
    
    //ViewModelUIUpdate
    func callToViewModelForUIUpdate(){
        
        self.deviceViewModel =  DeviceViewModel()
        
        self.deviceViewModel.bindViewModelToController = {
            self.updateDataSource()
            self.refreshDeviceList()
            
            if self.arrDevices.count == 0 {
                self.arrDevices = self.deviceViewModel.deviceData.devices ?? []
            }
        }
    }
    
    //Update Device List
    func updateDataSource(){
        
        self.dataSource = DeviceListView(cellIdentifier: "", items: self.deviceViewModel.deviceData.devices ?? [], configureCell: { (cell, evm) in
            
            //Set Device Data
            if evm.intensity ?? 0 > 0{
                
                cell.setup(title: evm.deviceName, subtitle: String(describing: "Intensity \(evm.intensity!)"), extra: evm.mode, body: evm.productType)
                
            }else if evm.position ?? 0 > 0 {
                
                cell.setup(title: evm.deviceName, subtitle: String(describing: "Position \(evm.position!)"), extra: evm.mode, body: evm.productType)
                
            }else if evm.temperature ?? 0 > 0{
                
                cell.setup(title: evm.deviceName, subtitle: String(describing: "Temperature \(evm.temperature!)"), extra: evm.mode, body: evm.productType)
            }else {
                
                cell.setup(title: evm.deviceName, subtitle: String(describing: ""), extra: evm.mode, body: evm.productType)
            }
        })
        
        DispatchQueue.main.async {
            self.tblDevices.dataSource = self.dataSource
            self.tblDevices.reloadData()
        }
    }
    
    //Refresh Deives List
    func refreshDeviceList(){
        
        self.dataSource.refreshController = { (index) in
            
            self.showMessageWithCancelButtonAlert(title: "", message:NSLocalizedString("Are you sure, you want to delete?", comment: ""), cancelButton: true) { tagBtnTapped in
                if tagBtnTapped == 0{
                    
                    print(index)
                    self.deviceViewModel.deviceData.devices?.remove(at: index)
                    DispatchQueue.main.async {
                        self.tblDevices.dataSource = self.dataSource
                        self.tblDevices.reloadData()
                    }
                }else {
                    //self.callToViewModelForUIUpdate()
                }
            }
        }
    }
}

//Apply Filter
extension ViewController : FilterAppyDelegate {
    
    func filterDevices(arrFilter: [String]) {
        
        self.dismiss(animated: true, completion: nil)
        
        UtilsClass.sharedInstance.setMyUserDefaults(value: arrFilter, key: MyUserDefaultsKey.saveFilter)
        if arrFilter.count > 0 {
            
            self.deviceViewModel.deviceData.devices?.removeAll()
            for strFilterType in arrFilter {
                
                let arrFiltred : [Device] = self.arrDevices.filter{ $0.productType == (strFilterType) }
                if arrFiltred.count > 0 {
                    
                    for objDevies in arrFiltred {
                        self.deviceViewModel.deviceData.devices?.append(objDevies)
                    }
                }
            }
            DispatchQueue.main.async {
                self.tblDevices.dataSource = self.dataSource
                self.tblDevices.reloadData()
            }
        }else {
            self.deviceViewModel.deviceData.devices = self.arrDevices
        }
    }
}
