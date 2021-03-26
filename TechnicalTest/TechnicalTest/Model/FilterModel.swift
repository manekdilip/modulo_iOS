//
//  FilterModel.swift
//  TechnicalTest

import Foundation

struct FilterModel : Codable {

    var isSelected : Bool?
    var productType : String?
    var index : Int?
    
    init() {
        
        self.isSelected = false
        self.productType = ""
        self.index = 0
    }
}
