//
//  ProfileOptionButton.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/23/21.
//

import UIKit

class ProfileOptionButton: UIButton {
    
    //MARK: - Init
    
    init(withImage image: UIImage) {
        super.init(frame: .zero)
        
        setImage(image, for: .normal)
        tintColor = UIColor.systemGray.withAlphaComponent(0.5)
        imageView?.contentMode = .scaleAspectFill
     
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
