//
//  ProfileHeader.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/16/21.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
    
    //MARK: - Properties
    
    static let reuseID = "ProfileHeader"
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHeader()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureHeader() {
        backgroundColor = .systemRed
    }
    
}
