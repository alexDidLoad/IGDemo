//
//  AttributedTitleButton.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/9/21.
//

import UIKit

class AttributedTitleButton: UIButton {
    
    //MARK: - Init
    
    init(title: String, boldedTitle: String) {
        super.init(frame: .zero)
        
        let attributes: [NSAttributedString.Key : Any]    = [.foregroundColor : UIColor.white.withAlphaComponent(0.9), .font : UIFont.systemFont(ofSize: 16)]
        let boldAttribute: [NSAttributedString.Key : Any] = [.foregroundColor : UIColor.white.withAlphaComponent(0.9), .font : UIFont.boldSystemFont(ofSize: 16)]
        let attributedTitle                               = NSMutableAttributedString(string: title, attributes: attributes)
        attributedTitle.append(NSAttributedString(string: boldedTitle, attributes: boldAttribute))
        setAttributedTitle(attributedTitle, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
