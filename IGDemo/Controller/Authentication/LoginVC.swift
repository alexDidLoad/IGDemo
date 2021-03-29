//
//  LoginVC.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/9/21.
//

import UIKit

protocol AuthenticationDelegate: AnyObject {
    func authenticationComplete()
}

class LoginVC: UIViewController {
    
    //MARK: - UIComponents
    
    private let iconImage: UIImageView = {
        let iv         = UIImageView(image: ImageAssets.instagramLogo)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let emailTextField    = CustomTextField(placeholder: "Email", isSecureEntry: false)
    private let passwordTextField = CustomTextField(placeholder: "Password", isSecureEntry: true)
    
    private let loginButton: UIButton = {
        let button = AuthButton(withTitle: "Log in")
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        return button
    }()
    
    
    private let forgotPasswordButton: UIButton = {
        let button = AttributedTitleButton(title: "Forgot your password? ", boldedTitle: "Get help signing in")
        button.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
        return button
    }()
    
    
    private let dontHaveAccountButton: UIButton = {
        let button = AttributedTitleButton(title: "Don't have an account?  ", boldedTitle: "Sign up")
        button.addTarget(self, action: #selector(didTapDontHaveAccount), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Properties
    
    weak var delegate: AuthenticationDelegate?
    private var viewModel = LoginViewModel()
    
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
    }
    
    
    private func configureUI() {
        configureGradientLayer()
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 120)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         paddingTop: 32)
        
        let stack     = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, forgotPasswordButton])
        stack.axis    = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor,
                     leading: view.leadingAnchor,
                     trailing: view.trailingAnchor,
                     paddingTop: 32,
                     paddingLeading: 32,
                     paddingTrailing: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    //MARK: - Selectors
    
    @objc private func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        updateForm()
    }
    
    
    @objc private func didTapLogin() {
        guard let email    = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        AuthService.logUserIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            
            if let error = error {
                print("DEBUG: Failed to log user in \(error.localizedDescription)")
            }
            self.delegate?.authenticationComplete()
        }
    }
    
    
    @objc private func didTapForgotPassword() {
        print("didTapForgotPassword")
    }
    
    
    @objc private func didTapDontHaveAccount() {
        let destVC = RegisterVC()
        destVC.delegate = delegate
        navigationController?.pushViewController(destVC, animated: true)
    }
}

//MARK: - FormViewModel

extension LoginVC: FormViewModel {
    
    func updateForm() {
        loginButton.isEnabled = viewModel.formIsValid
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
    }
    
}
