//
//  InformationController.swift
//  HabbitManagement
//
//  Created by 강호성 on 2021/05/30.
//

import UIKit

class InformationController: UIViewController {
    
    // MARK: - Properties
    
    private let iconImage: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "venom-7"))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let appnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = " 습관관리"
        return label
    }()
    
    private let versionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "   Ver 1.0"
        return label
    }()
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "하루 한번, 좋은 습관"
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "작지만 나를 바꾸는 습관들로 달력에 표시해보세요 !"
        return label
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    
    // MARK: - Helpers
    
    func configure() {
        navigationItem.title = "About"
        view.backgroundColor = .white
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 70, width: 70)
        iconImage.layer.cornerRadius = 70 / 3
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 100)

        let stack = UIStackView(arrangedSubviews: [appnameLabel, versionLabel])
        stack.axis = .vertical
        stack.spacing = 5
        
        view.addSubview(stack)
        stack.centerX(inView: view)
        stack.anchor(top: iconImage.bottomAnchor, paddingTop: 30)
    
        view.addSubview(informationLabel)
        informationLabel.anchor(top: stack.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                                paddingTop: 50, paddingLeft: 110, paddingRight: 10)
        
        view.addSubview(infoLabel)
        infoLabel.anchor(top: informationLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 50, paddingRight: 10)
    }
}
