//
//  HabbitCell.swift
//  HabbitManagement
//
//  Created by 하동훈 on 2021/05/24.
//

import UIKit

class HabbitCell: UICollectionViewCell {
    // MARK: - Properties
    
    let nameLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = .black
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let slashLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.textColor = .black
        label.text = "/"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let goalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Methods
    
    func addViews() {
        addSubview(nameLable)
        addSubview(countLabel)
        addSubview(slashLabel)
        addSubview(goalLabel)
        
        nameLable.anchor(top: self.topAnchor,
                         left: self.leftAnchor,
                         right: self.rightAnchor,
                         paddingTop: 8,
                         paddingLeft: 8,
                         paddingRight: 8,
                         width: self.bounds.width - 16,
                         height: 20)
        countLabel.anchor(top: nameLable.bottomAnchor,
                          right: slashLabel.leftAnchor,
                          paddingTop: 16,
                          paddingRight: 8,
                          width: self.bounds.width / 3,
                          height: self.bounds.height / 4)
        slashLabel.center(inView: self)
        goalLabel.anchor(top: nameLable.bottomAnchor,
                         left: slashLabel.rightAnchor,
                         paddingTop: 48,
                         paddingLeft: 8,
                         width: self.bounds.width / 3,
                         height: self.bounds.height / 4)
    }
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
