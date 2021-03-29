//
//  UserCell.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/29/21.
//

import UIKit

class UserCell: UITableViewCell {
    
    //MARK: - UIComponents
    
    private let profileImageView: UIImageView = {
        let iv              = UIImageView()
        iv.contentMode      = .scaleAspectFill
        iv.clipsToBounds    = true
        iv.backgroundColor  = .systemGray2
        iv.image            = SFSymbols.emptyPhoto
        return iv
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font      = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font      = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray3
        return label
    }()
    
    //MARK: - Properties
    
    var user: User? {
        didSet {
            usernameLabel.text = user?.username
            fullnameLabel.text = user?.fullname
        }
    }
    
    static let reuseID = "UserCell"
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCell()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureCell() {
        
        addSubview(profileImageView)
        profileImageView.setDimensions(height: 72, width: 72)
        profileImageView.layer.cornerRadius = 72 / 2
        profileImageView.centerY(inView: self,
                                 leadingAnchor: leadingAnchor,
                                 paddingLeading: 12)
        
        let stack       = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        stack.axis      = .vertical
        stack.spacing   = 6
        stack.alignment = .leading
        
        addSubview(stack)
        stack.centerY(inView: profileImageView,
                      leadingAnchor: profileImageView.trailingAnchor,
                      paddingLeading: 8)
    
    }
    
}
