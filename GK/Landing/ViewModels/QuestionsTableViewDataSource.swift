//
//  QuestionsTableViewDataSource.swift
//  GK
//
//  Created by Oscar on 2021/02/12.
//

import Foundation
import UIKit

class QuestionsTableViewDataSource<CELL : UITableViewCell,T> : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var cellIdentifier : String!
    private var items : [T]!
    var configureCell : (CELL, T) -> () = {_,_ in }
    var selectHandler: (T) -> ()
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL, T) -> (), selectHandler: @escaping (T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.selectHandler = selectHandler
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
        let item = self.items[indexPath.row]
        self.configureCell(cell, item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        selectHandler(item)
    }
}
