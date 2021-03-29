//
//  ProfileCell.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/16/21.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    
    //MARK: - UIComponents
    
    private let postImageView: UIImageView = {
        let iv           = UIImageView()
        iv.image         = SFSymbols.emptyPhoto
        iv.contentMode   = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    
    //MARK: - Properties
    
    static let reuseID = "ProfileCell"
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureCell() {
        
        addSubview(postImageView)
        postImageView.fillView(self)
    }
    
}
