//
//  UploadPostController.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/30/21.
//

import UIKit

protocol UploadPostControllerDelegate: AnyObject {
    func controllerDidFinishUploadingPost(_ controller: UploadPostController)
}

class UploadPostController: UIViewController {
    
    //MARK: - UIComponents
    
    private let photoImageView: UIImageView = {
        let iv                = UIImageView()
        iv.contentMode        = .scaleAspectFill
        iv.clipsToBounds      = true
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    private lazy var captionTextView: InputTextView = {
        let tv             = InputTextView()
        tv.placeHolderText = "Enter caption..."
        tv.font            = UIFont.systemFont(ofSize: 14)
        tv.delegate        = self
        return tv
    }()
    
    private let charCountLabel: UILabel = {
        let label       = UILabel()
        label.textColor = .systemGray3
        label.font      = UIFont.systemFont(ofSize: 14)
        label.text      = "0/100"
        return label
    }()
    
    //MARK: - Properties
    
    weak var delegate: UploadPostControllerDelegate?
    private var currentUser: User?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Init
    
    init(withImage image: UIImage, user: User) {
        super.init(nibName: nil, bundle: nil)
        photoImageView.image = image
        self.currentUser     = user
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func checkMaxLength(_ textView: UITextView) {
        if textView.text.count > 100 {
            textView.deleteBackward()
        }
    }
    
    
    private func configureUI() {
        view.backgroundColor              = .white
        navigationItem.title              = "Upload Post"
        navigationItem.leftBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(didTapShare))
        
        view.addSubview(photoImageView)
        photoImageView.setDimensions(height: 180, width: 180)
        photoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              paddingTop: 8)
        photoImageView.centerX(inView: view)
        
        
        view.addSubview(captionTextView)
        captionTextView.anchor(top: photoImageView.bottomAnchor,
                               leading: view.leadingAnchor,
                               trailing: view.trailingAnchor,
                               paddingTop: 16,
                               paddingLeading: 12,
                               paddingTrailing: 12,
                               height: 64)
        
        view.addSubview(charCountLabel)
        charCountLabel.anchor(top: captionTextView.bottomAnchor,
                              trailing: captionTextView.trailingAnchor)
        
    }
    
    //MARK: - Selectors
    
    @objc private func didTapShare() {
        guard let selectedImage = photoImageView.image else { return }
        guard let caption       = captionTextView.text else { return }
        guard let user          = currentUser else { return }
        
        showLoader(true)
        
        PostService.uploadPost(caption: caption, image: selectedImage, user: user) { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                print("Failed to upload post with image: \(error.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
                self.showLoader(false)
                self.delegate?.controllerDidFinishUploadingPost(self)
            }
        }
    }
    
    
    @objc private func didTapCancel() {
        dismiss(animated: true)
    }
    
}

//MARK: - UITextViewDelegate

extension UploadPostController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView)
        let count = textView.text.count
        charCountLabel.text = "\(count)/100"
    }
    
}
