//
//  FeedbackController.swift
//  HabbitManagement
//
//  Created by 강호성 on 2021/05/30.
//

import UIKit

protocol FeedbackControllerDelegate: class {
    func DidSendMessage(_ controller: FeedbackController)
}

class FeedbackController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: FeedbackControllerDelegate?
    
    private let emailTextField: UITextField = {
        let tf = CustomTextField(placeholder: "이메일을 남겨주시면 답변을 보내드립니다.")
        tf.keyboardType = .emailAddress
        tf.font = UIFont.systemFont(ofSize: 15)
        return tf
    }()
    
    private let commentTextField: UITextField = {
        let ctf = CustomTextField(placeholder: "여기에 의견을 자유롭게 남겨주세요.")
        ctf.font = UIFont.systemFont(ofSize: 15)
        ctf.contentVerticalAlignment = .top
        return ctf
    }()
    
    private let suggestionButton: UIButton = {
        let button = UIButton()
        button.setTitle("제출하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).withAlphaComponent(0.8)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSuggestion), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configure()
    }
    
    // MARK: - Actions
    
    @objc func handleSuggestion() {
        self.delegate?.DidSendMessage(self)
    }
    
    
    // MARK: - Helpers
    
    func configure() {
        navigationItem.title = "의견 보내기"
        
        view.addSubview(emailTextField)
        emailTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 10, paddingRight: 10)
        
        view.addSubview(commentTextField)
        commentTextField.anchor(top: emailTextField.bottomAnchor, left: view.leftAnchor,
                                bottom: view.bottomAnchor, right: view.rightAnchor,
                                paddingTop: 15, paddingLeft: 10, paddingBottom: 300, paddingRight: 10)
        
        view.addSubview(suggestionButton)
        suggestionButton.anchor(top: commentTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingRight: 40)
    }
}
