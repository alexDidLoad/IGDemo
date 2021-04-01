//
//  UIViewController+Ext.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/9/21.
//

import UIKit
import JGProgressHUD

extension UIViewController {
    
    static let hud = JGProgressHUD(style: .dark)
    
    func showLoader(_ show: Bool) {
        view.endEditing(true)
        
        if show {
            UIViewController.hud.show(in: view, animated: true)
        } else {
            UIViewController.hud.dismiss()
        }
    }
    
    
    func configureGradientLayer() {
        
        let gradient       = CAGradientLayer()
        gradient.colors    = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradient.locations = [0, 1.5]
        view.layer.addSublayer(gradient)
        gradient.frame     = view.bounds
    }
    
}
