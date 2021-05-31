//
//  ProfileCell.swift
//  HabbitManagement
//
//  Created by 강호성 on 2021/05/30.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "ProfileCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 3 생성자에서 모든 것을 콘텐츠에 하위 뷰로 추가
        contentView.addSubview(label)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 하위 보기
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 15, y: 0,
                             width: contentView.frame.size.width,
                             height: contentView.frame.size.height)
    }
    
    // 테이블이 셀을 재사용하려고 할때마다 호출
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    // model로 cell 구성
    public func configure(with model: SettingsOption) {
        label.text = model.title
    }
}
