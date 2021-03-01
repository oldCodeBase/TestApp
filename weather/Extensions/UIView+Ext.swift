//
//  UIView+Ext.swift
//  weather
//
//  Created by Ibragim Akaev on 28/02/2021.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
