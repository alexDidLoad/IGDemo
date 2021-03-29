//
//  ProfileHeader.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/16/21.
//

import UIKit
import SDWebImage

class ProfileHeader: UICollectionReusableView {
    
    //MARK: - UIComponents
    
    private let profileImageView: UIImageView = {
        let iv             = UIImageView()
        iv.contentMode     = .scaleAspectFill
        iv.clipsToBounds   = true
        iv.backgroundColor = .systemGray2
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label  = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private lazy var editProfileFollowButton: UIButton = {
        let button                = UIButton(type: .system)
        button.layer.cornerRadius = 3
        button.layer.borderWidth  = 0.5
        button.layer.borderColor  = UIColor.systemGray4.cgColor
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleEditProfileTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var postsLabel: UILabel = {
        let label            = UILabel()
        label.numberOfLines  = 0
        label.textAlignment  = .center
        label.attributedText = attributedStatText(value: 5, label: "posts")
        return label
    }()
    
    private lazy var followersLabel: UILabel = {
        let label           = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = attributedStatText(value: 10, label: "followers")
        return label
    }()
    
    private lazy var followingLabel: UILabel = {
        let label           = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = attributedStatText(value: 2, label: "following")
        return label
    }()
    
    private lazy var gridButton: ProfileOptionButton = {
        let button = ProfileOptionButton(withImage: SFSymbols.gridFill)
        button.imageView?.setDimensions(height: 30, width: 30)
        return button
    }()
    
    private lazy var listButton: ProfileOptionButton = {
        let button = ProfileOptionButton(withImage: SFSymbols.list)
        button.imageView?.setDimensions(height: 30, width: 30)
        return button
    }()
    
    private lazy var bookmarkButton: ProfileOptionButton = {
        let button = ProfileOptionButton(withImage: SFSymbols.bookmarkFill)
        button.imageView?.setDimensions(height: 25, width: 25)
        return button
    }()
    
    //MARK: - Properties
    
    var viewModel: ProfileHeaderViewModel? {
        didSet { configure() }
    }
    
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
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        nameLabel.text      = viewModel.fullname
        
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        
        editProfileFollowButton.setTitle(viewModel.followButtonText, for: .normal)
        editProfileFollowButton.setTitleColor(viewModel.followButtonTextColor, for: .normal)
        editProfileFollowButton.backgroundColor = viewModel.followButtonBackgroundColor
    }
    
    
    private func attributedStatText(value: Int, label: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [ .font : UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: label, attributes: [.font : UIFont.systemFont(ofSize: 14),
                                                                             .foregroundColor : UIColor.systemGray3] ))
        return attributedText
    }
    
    
    private func configureHeader() {
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor,
                                leading: leadingAnchor,
                                paddingTop: 16,
                                paddingLeading: 12,
                                height: 80,
                                width: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        
        addSubview(nameLabel)
        nameLabel.centerX(inView: profileImageView)
        nameLabel.anchor(top: profileImageView.bottomAnchor,
                         paddingTop: 8)
        
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top: nameLabel.bottomAnchor,
                                       leading: leadingAnchor,
                                       trailing: trailingAnchor,
                                       paddingTop: 16,
                                       paddingLeading: 24,
                                       paddingTrailing: 24)
        
        let stackView          = UIStackView(arrangedSubviews: [postsLabel, followersLabel, followingLabel])
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.centerY(inView: profileImageView)
        stackView.anchor(leading: profileImageView.trailingAnchor,
                         trailing: trailingAnchor,
                         paddingLeading: 12,
                         paddingTrailing: 12,
                         height: 50)
        
        let topDivider = UIView()
        topDivider.backgroundColor = UIColor.systemGray5
        
        let bottomDivider = UIView()
        bottomDivider.backgroundColor = UIColor.systemGray5
        
        let buttonStack = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        buttonStack.distribution = .fillEqually
        
        addSubview(buttonStack)
        buttonStack.anchor(leading: leadingAnchor,
                           bottom: bottomAnchor,
                           trailing: trailingAnchor,
                           height: 50)
        
        addSubview(topDivider)
        topDivider.anchor(top: buttonStack.topAnchor,
                          leading: leadingAnchor,
                          trailing: trailingAnchor,
                          height: 0.5)
        
        addSubview(bottomDivider)
        bottomDivider.anchor(top: buttonStack.bottomAnchor,
                             leading: leadingAnchor,
                             trailing: trailingAnchor,
                             height: 0.5)
    }
    
    //MARK: - Selectors
    
    @objc private func handleEditProfileTapped() {
        print("edit tap")
    }
    
}
