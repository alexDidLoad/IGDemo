//
//  InputTextView.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/30/21.
//

import UIKit

class InputTextView: UITextView {
    
    //MARK: - Properties
    
    private let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray3
        return label
    }()
    
    var placeHolderText: String? {
        didSet { placeHolderLabel.text = placeHolderText }
    }
    
    //MARK: - Init
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        configureTextView()
        configureNotificationCenter()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    
    private func configureTextView() {
        addSubview(placeHolderLabel)
        placeHolderLabel.anchor(top: topAnchor,
                                leading: leadingAnchor,
                                paddingTop: 6,
                                paddingLeading: 8)
    }

    //MARK: - Selectors

    @objc private func handleTextDidChange() {
        placeHolderLabel.isHidden = !text.isEmpty
    }
}
