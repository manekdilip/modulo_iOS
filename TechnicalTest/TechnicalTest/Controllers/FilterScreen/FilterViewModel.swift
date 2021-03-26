//
//  FilterViewModel.swift
//  TechnicalTest

import Foundation

class FilterViewModel : NSObject {
    
    var arrFilterOption :[FilterModel] = []
    private(set) var deviceFilterData : [FilterModel]! {
        didSet {
            self.bindFilterViewModelToController()
        }
    }
    
    var bindFilterViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        getDeviceFilterData()
    }

    func getDeviceFilterData() {
        
        var objFilterOne = FilterModel()
        objFilterOne.isSelected = false
        objFilterOne.productType = "Light"
        objFilterOne.index = 0
        self.arrFilterOption.append(objFilterOne)
        
        var objFilterSecond = FilterModel()
        objFilterSecond.isSelected = false
        objFilterSecond.productType = "RollerShutter"
        objFilterSecond.index = 1
        self.arrFilterOption.append(objFilterSecond)
        
        var objFilterThree = FilterModel()
        objFilterThree.isSelected = false
        objFilterThree.productType = "Heater"
        objFilterThree.index = 2
        self.arrFilterOption.append(objFilterThree)
        
        self.deviceFilterData = self.arrFilterOption
    }
}
