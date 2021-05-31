//
//  ErrorReportController.swift
//  HabbitManagement
//
//  Created by 강호성 on 2021/05/30.
//

import UIKit

class ErrorReportController: UIViewController {
    
    // MARK: - Properties
    
    private let emailTextField: UITextField = {
        let tf = CustomTextField(placeholder: "이메일을 남겨주시면 답변을 보내드립니다.")
        tf.keyboardType = .emailAddress
        tf.font = UIFont.systemFont(ofSize: 15)
        return tf
    }()
    
    private let commentTextField: UITextField = {
        let ctf = CustomTextField(placeholder: "발견한 오류를 알려주세요. 신속하게 수정하겠습니다.")
        ctf.font = UIFont.systemFont(ofSize: 15)
        ctf.contentVerticalAlignment = .top
        return ctf
    }()
    
    private let suggestionButton: UIButton = {
        let button = UIButton()
        button.setTitle("제출하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
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
        print("제출하기")
    }
    
    
    // MARK: - Helpers
    
    func configure() {
        navigationItem.title = "오류 제보하기"
        
        view.addSubview(emailTextField)
        emailTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 10, paddingRight: 10)
        
        view.addSubview(commentTextField)
        commentTextField.anchor(top: emailTextField.bottomAnchor, left: view.leftAnchor,
                                bottom: view.bottomAnchor, right: view.rightAnchor,
                                paddingTop: 15, paddingLeft: 10, paddingBottom: 300, paddingRight: 10)
        
        view.addSubview(suggestionButton)
        suggestionButton.anchor(top: commentTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingRight: 10)
    }
}

