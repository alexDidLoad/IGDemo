//
//  LoginVC.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/9/21.
//

import UIKit

class LoginVC: UIViewController {
    
    //MARK: - UIComponents
    
    //MARK: - Properties
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       configureUI()
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.bounds
    
    
    }
    
    //MARK: - Selectors
    
}
