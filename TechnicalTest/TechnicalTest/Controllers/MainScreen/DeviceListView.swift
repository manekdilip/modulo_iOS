//
//  DeviceListView.swift
//  TechnicalTest


import Foundation
import UIKit

class DeviceListView<CELL : DeviceListCell,T> : NSObject, UITableViewDataSource,UITableViewDelegate {
    
    private var cellIdentifier : String!
    private var items : [T]!
    var configureCell : (CELL, T) -> () = {_,_ in }
    var refreshController : ((Int) -> ()) = {_ in }
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL, T) -> ()) {
       
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(DeviceListCell.self, indexPath: indexPath)
        cell.selectionStyle = .none
        
        //Set Deive Data
        let item = self.items[indexPath.row]
        self.configureCell(cell as! CELL, item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            
            refreshController(indexPath.row)
        }
    }
}

