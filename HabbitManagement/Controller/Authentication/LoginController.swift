//
//  LoginController.swift
//  HabbitManagement
//
//  Created by 강호성 on 2021/05/25.
//

import UIKit

protocol AuthenticationDelegate: class {
    func authenticationCompletion()
}

class LoginController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: AuthenticationDelegate?
    
    private let emailTextField: UITextField = {
        let tf = CustomTextField(placeholder: "이메일")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = CustomTextField(placeholder: "비밀번호")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(TapLogIn), for: .touchUpInside)
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "계정이 없으신가요? ", secondPart: "회원가입")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Liftcycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNotificationObservers()
    }
    
    // MARK: - Actions
    
    @objc func TapLogIn() {
        print("DEBUG: log in")
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        AuthService.logUserIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Failed to register user \(error.localizedDescription)")
                return
            }
            self.delegate?.authenticationCompletion()
        }
    }
    
    @objc func handleShowSignUp() {
        let controller = RegistrationController()
        controller.delegate = delegate
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            emailTextField.text = sender.text
        } else {
            passwordTextField.text = sender.text
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .black
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, dontHaveAccountButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: view.topAnchor, left: view.leftAnchor,
                     right: view.rightAnchor, paddingTop: 200, paddingLeft: 32, paddingRight: 32)
        
    }
    
    // textfield 에 문자를 입력할 때
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}
