//
//  SwitchCell.swift
//  HabbitManagement
//
//  Created by 강호성 on 2021/05/30.
//

import UIKit

class SwitchCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "SwitchCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let mySwitch: UISwitch = {
        let myswitch = UISwitch()
        myswitch.tintColor = .systemBlue
        return myswitch
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(mySwitch)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 15, y: 0,
                             width: contentView.frame.size.width,
                             height: contentView.frame.size.height)
        
        mySwitch.sizeToFit()
        mySwitch.frame = CGRect(x: contentView.frame.size.width - mySwitch.frame.size.width - 20,
                                y: (contentView.frame.size.height - mySwitch.frame.size.height) / 2,
                                width: mySwitch.frame.size.width,
                                height: mySwitch.frame.size.height)
    }
    
    // 테이블이 셀을 재사용하려고 할때마다 호출
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        mySwitch.isOn = false
    }
    
    // model로 cell 구성
    public func configure(with model: SettingsSwitchOption) {
        label.text = model.title
        mySwitch.isOn = model.isOn
    }
}

