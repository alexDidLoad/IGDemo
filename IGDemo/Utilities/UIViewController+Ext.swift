//
//  UIViewController+Ext.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/9/21.
//

import UIKit

extension UIViewController {
    
    func configureGradientLayer() {
        
        let gradient       = CAGradientLayer()
        gradient.colors    = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradient.locations = [0, 1.5]
        view.layer.addSublayer(gradient)
        gradient.frame     = view.bounds
    }
    
    
}
