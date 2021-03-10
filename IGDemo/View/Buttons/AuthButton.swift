//
//  AuthButton.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/9/21.
//

import UIKit

class AuthButton: UIButton {
    
    
    //MARK: - Init
    
    init(withTitle title: String) {
        super.init(frame: .zero)
        
        isEnabled           = false
        backgroundColor     = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.67)
        layer.cornerRadius  = 5
        titleLabel?.font    = UIFont.boldSystemFont(ofSize: 20)
        setTitle(title, for: .normal)
        setTitleColor(UIColor.white.withAlphaComponent(0.67), for: .normal)
        setHeight(height: 50)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
