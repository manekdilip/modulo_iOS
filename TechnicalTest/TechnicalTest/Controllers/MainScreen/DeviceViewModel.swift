//
//  DeviceViewModel.swift
//  TechnicalTest

import Foundation

class DeviceViewModel : NSObject {
    
    private var apiService : APIService!
    var deviceData : DevicesModel! {
        didSet {
            self.bindViewModelToController()
        }
    }
    
    var bindViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  APIService()
        getDeviceData()
    }

    //Call API for Get Devie Data
    func getDeviceData() {
        
        self.apiService.callApiToGetDevicesData{ (deviceData) in
            self.deviceData = deviceData
        }
    }
}
