//
//  TableView+Ext.swift
//  weather
//
//  Created by Ibragim Akaev on 28/02/2021.
//

import UIKit

extension UITableView {
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
