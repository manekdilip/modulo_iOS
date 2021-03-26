//
//  FilterOptionView.swift
//  TechnicalTest

import Foundation
import UIKit

class FilterOptionView<CELL : FilterCell,T> : NSObject, UITableViewDataSource,UITableViewDelegate {
    
    private var cellIdentifier : String!
    private var items : [T]!
    var configureCell : (CELL, T) -> () = {_,_ in }
    var refreshController : (() -> ()) = {}
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL, T) -> ()) {
       
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(FilterCell.self, indexPath: indexPath)
        cell.selectionStyle = .none
        
        //Set Deive Data
        let item = self.items[indexPath.row]
        self.configureCell(cell as! CELL, item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
