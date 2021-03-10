//
//  CustomTextField.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/9/21.
//

import UIKit

class CustomTextField: UITextField {
   
    //MARK: - Init
    
    init(placeholder: String, isSecureEntry isSecure: Bool) {
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
       
        leftView              = spacer
        leftViewMode          = .always
        borderStyle           = .none
        textColor             = .white
        keyboardAppearance    = .dark
        keyboardType          = .emailAddress
        backgroundColor       = UIColor.white.withAlphaComponent(0.1)
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [ .foregroundColor : UIColor.white.withAlphaComponent(0.7)])
        isSecureTextEntry     = isSecure
        setHeight(height: 50)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
