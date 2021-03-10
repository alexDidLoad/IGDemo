//
//  RegisterVC.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/9/21.
//

import UIKit

class RegisterVC: UIViewController {
    
    //MARK: - UIComponents
    
    private let profilePhotoButton: UIButton = {
        let button                    = UIButton(type: .system)
        button.tintColor              = .white
        button.imageView?.contentMode = .scaleAspectFill
        button.setImage(ImageAssets.addPhoto, for: .normal)
        button.addTarget(self, action: #selector(didTapProfilePhoto), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField    = CustomTextField(placeholder: "Email", isSecureEntry: false)
    private let passwordTextField = CustomTextField(placeholder: "Password", isSecureEntry: true)
    private let fullnameTextField = CustomTextField(placeholder: "Full name", isSecureEntry: false)
    private let usernameTextField = CustomTextField(placeholder: "Username", isSecureEntry: false)
    
    private let signupButton: UIButton = {
        let button = AuthButton(withTitle: "Sign up")
        button.addTarget(self, action: #selector(didTapSignup), for: .touchUpInside)
        return button
    }()
    
    private let alreadyHaveAnAccountButton: UIButton = {
        let button = AttributedTitleButton(title: "Already have an account? ", boldedTitle: "Log in")
        button.addTarget(self, action: #selector(didTapAlreadyHaveAnAccount), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Properties
    
    private var viewModel = RegistrationViewModel()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNotificationObservers()
    }
    
    //MARK: - Helpers
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    
    private func configureUI() {
        
        configureGradientLayer()
        
        view.addSubview(profilePhotoButton)
        profilePhotoButton.centerX(inView: view)
        profilePhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                  paddingTop: 32,
                                  height: 140,
                                  width: 140)
        
        
        let stack        = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullnameTextField, usernameTextField, signupButton])
        stack.axis       = .vertical
        stack.spacing    = 20
        
        let stackPadding: CGFloat = 32
        view.addSubview(stack)
        stack.centerX(inView: view)
        stack.anchor(top: profilePhotoButton.bottomAnchor,
                     leading: view.leadingAnchor,
                     trailing: view.trailingAnchor,
                     paddingTop: stackPadding,
                     paddingLeading: stackPadding,
                     paddingBottom: stackPadding,
                     paddingTrailing: stackPadding)
        
        view.addSubview(alreadyHaveAnAccountButton)
        alreadyHaveAnAccountButton.centerX(inView: view)
        alreadyHaveAnAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
    }
    
    //MARK: - Selectors
    
    @objc private func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        } else if sender == fullnameTextField {
            viewModel.fullname = sender.text
        } else {
            viewModel.username = sender.text
        }
        
        updateForm()
    }
    
    
    @objc private func didTapProfilePhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
        
    }
    
    
    @objc private func didTapSignup() {
        print("didTapSignup")
    }
    
    
    @objc private func didTapAlreadyHaveAnAccount() {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - FormViewModel

extension RegisterVC: FormViewModel {
    
    func updateForm() {
        signupButton.isEnabled = viewModel.formIsValid
        signupButton.backgroundColor = viewModel.buttonBackgroundColor
        signupButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
    }
    
}

//MARK: - UIImagePickerControllerDelegate

extension RegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        
        profilePhotoButton.layer.cornerRadius  = profilePhotoButton.frame.width / 2
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.borderWidth   = 1.5
        profilePhotoButton.layer.borderColor   = UIColor.white.cgColor
        profilePhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.dismiss(animated: true)
    }
    
}
