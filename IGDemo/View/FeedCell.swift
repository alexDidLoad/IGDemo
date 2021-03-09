//
//  FeedCell.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/8/21.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    //MARK: - UIComponents
    
    private let profileImageView: UIImageView = {
        let iv                      = UIImageView()
        iv.contentMode              = .scaleAspectFill
        iv.clipsToBounds            = true
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius       = 20
        iv.backgroundColor          = .systemRed
        return iv
    }()
    
    
    private lazy var usernameButton: UIButton = {
        let button              = UIButton(type: .system)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("User", for: .normal)
        button.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var moreButton: UIButton = {
        let button       = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(SFSymbols.ellipsis, for: .normal)
        button.addTarget(self, action: #selector(didTapMore), for: .touchUpInside)
        return button
    }()
    
    
    private let postedImageView: UIImageView = {
        let iv                      = UIImageView()
        iv.contentMode              = .scaleAspectFill
        iv.clipsToBounds            = true
        iv.isUserInteractionEnabled = true
        iv.image                    = SFSymbols.emptyPhoto
        iv.backgroundColor          = .systemGray
        iv.tintColor                = .systemGreen
        return iv
    }()
    
    
    private lazy var heartButton: UIButton = {
        let button       = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(SFSymbols.heart, for: .normal)
        button.addTarget(self, action: #selector(didTapHeart), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var commentButton: UIButton = {
        let button       = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(SFSymbols.comment, for: .normal)
        button.addTarget(self, action: #selector(didTapComment), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var sendButton: UIButton = {
        let button       = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(SFSymbols.send, for: .normal)
        button.addTarget(self, action: #selector(didTapSend), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var bookmarkButton: UIButton = {
        let button       = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(SFSymbols.bookmark, for: .normal)
        button.addTarget(self, action: #selector(didTapBookmark), for: .touchUpInside)
        return button
    }()
    
    
    private let likesLabel: UILabel = {
        let label  = UILabel()
        label.text = "1 like"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    
    private let captionLabel: UILabel = {
        let label  = UILabel()
        label.text = "This is a test caption...😉"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    
    private let postTimeLabel: UILabel = {
        let label       = UILabel()
        label.text      = "2 days ago"
        label.font      = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray2
        return label
    }()
    
    
    //MARK: - Properties
    
    static let reuseID = "FeedCell"
    
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
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor,
                                leading: leadingAnchor,
                                paddingTop: 8,
                                paddingLeading: 8,
                                height: 40,
                                width: 40)
        
        addSubview(usernameButton)
        usernameButton.centerY(inView: profileImageView,
                               leadingAnchor: profileImageView.trailingAnchor,
                               paddingLeading: 8)
        
        addSubview(moreButton)
        moreButton.centerY(inView: profileImageView)
        moreButton.anchor(trailing: trailingAnchor,
                          paddingTrailing: 12)
        
        addSubview(postedImageView)
        postedImageView.anchor(top: profileImageView.bottomAnchor,
                               leading: leadingAnchor,
                               bottom: bottomAnchor,
                               trailing: trailingAnchor,
                               paddingTop: 6,
                               paddingBottom: 100)
        
        let stack          = UIStackView(arrangedSubviews: [heartButton, commentButton, sendButton])
        stack.axis         = .horizontal
        stack.distribution = .fillEqually
        
        addSubview(stack)
        stack.anchor(top: postedImageView.bottomAnchor,
                     leading: leadingAnchor,
                     paddingTop: 6,
                     paddingLeading: 4,
                     height: 30,
                     width: 120)
        
        addSubview(bookmarkButton)
        bookmarkButton.centerY(inView: stack)
        bookmarkButton.anchor(trailing: trailingAnchor,
                              paddingTrailing: 12)
        
        addSubview(likesLabel)
        likesLabel.anchor(top: stack.bottomAnchor,
                          leading: leadingAnchor,
                          paddingTop: 4,
                          paddingLeading: 12)
        
        addSubview(captionLabel)
        captionLabel.anchor(top: likesLabel.bottomAnchor,
                            leading: likesLabel.leadingAnchor,
                            paddingTop: 4)
        
        addSubview(postTimeLabel)
        postTimeLabel.anchor(top: captionLabel.bottomAnchor,
                            leading: captionLabel.leadingAnchor,
                            paddingTop: 6)
        
    }
    
    
    //MARK: - Selectors
    
    @objc private func didTapUsername() {
        print("didTapUsername")
    }
    
    
    @objc private func didTapMore() {
        print("didTapMore")
    }
    
    
    @objc private func didTapHeart() {
        print("didTapHeart")
    }
    
    
    @objc private func didTapComment() {
        print("didTapComment")
    }
    
    
    @objc private func didTapSend() {
        print("didTapSend")
    }
    
    
    @objc private func didTapBookmark() {
        print("didTapBookmark")
    }
}
