//
//  AddView.swift
//  HabbitManagement
//
//  Created by minii on 2021/05/23.
//

import UIKit

class AddView: UIScrollView {
    
    // contentView
    let contentView: UIView = {
        let contentview = UIView()
        return contentview
    }()
    
    // 이름 라벨
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "이름"
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        // 라벨 사이즈는 폰트크기와 맞춤
        nameLabel.sizeToFit()
        return nameLabel
    }()
    
    // 습관이름 입력 텍스트필드
    let nameField: UITextField = {
        let nameField = UITextField()
        // 자동 텍스트 수정
        nameField.autocorrectionType = .no
        nameField.layer.borderWidth = 0.5
        nameField.layer.borderColor = UIColor.lightGray.cgColor
        nameField.backgroundColor = .secondarySystemFill
        nameField.placeholder = "습관 이름을 입력하세요..."
        nameField.addLeftPadding()
        return nameField
    }()
    
    // 횟수 라벨
    let routineCountLabel: UILabel = {
        let routineCountLabel = UILabel()
        routineCountLabel.text = "횟수"
        routineCountLabel.textColor = .black
        routineCountLabel.textAlignment = .center
        // 라벨 사이즈는 폰트크기와 맞춤
        routineCountLabel.sizeToFit()
        return routineCountLabel
    }()
    
    // 목표횟수 입력 텍스트필드
    let routineCountTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = .secondarySystemFill
        textField.placeholder = "목표 횟수를 입력하세요..."
        // 입력키보드 숫자로 변경
        textField.keyboardType = .numberPad
        textField.addLeftPadding()
        return textField
    }()
    
    // 색상 라벨
    let colorLabel: UILabel = {
        let colorLabel = UILabel()
        colorLabel.text = "색상"
        colorLabel.textColor = .black
        colorLabel.textAlignment = .center
        // 라벨 사이즈는 폰트크기와 맞춤
        colorLabel.sizeToFit()
        return colorLabel
    }()
    
    // 색상 버튼
    let colorButton: UIButton = {
        let colorButton = UIButton()
        colorButton.backgroundColor = .white
        colorButton.layer.borderWidth = 0.5
        colorButton.layer.borderColor = UIColor.lightGray.cgColor
        return colorButton
    }()
    
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = "알람시간"
        dateLabel.textColor = .black
        dateLabel.textAlignment = .center
        // 라벨 사이즈는 폰트크기와 맞춤
        dateLabel.sizeToFit()
        return dateLabel
    }()
    
    let dateTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.placeholder = "00:00"
        textField.font = UIFont.systemFont(ofSize: 50)
        textField.textAlignment = .center
        textField.adjustsFontSizeToFitWidth = true
        return textField
    }()
    
    // 메모 설명 입력필드
    let addNoteTextField: UITextView = {
        let textField = UITextView()
        textField.textColor = .black
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.backgroundColor = .secondarySystemFill
        textField.font = UIFont.systemFont(ofSize: 17)
        return textField
    }()
    
    // 추가하기 버튼 (floating 스타일)
    let addButton: UIButton = {
        let add = UIButton()
        add.setTitle("추가하기", for: .normal)
        add.setTitleColor(.white, for: .normal)
        add.backgroundColor = .link
        add.layer.borderWidth = 0.5
        add.layer.borderColor = UIColor.lightGray.cgColor
        return add
    }()
 
    // AddHabbitController에서 AddView가 인스턴스화 되면 실행
    func setConstraint() {
        let textFieldHeight: CGFloat = 50
        let textFieldWidth: CGFloat = self.frame.size.width - 50
        
        contentView.anchor(top: self.topAnchor, bottom: self.bottomAnchor)
        contentView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        contentView.centerX(inView: self)
        
        nameLabel.centerX(inView: contentView, topAnchor: contentView.topAnchor, paddingTop: 30)
        nameField.setDimensions(height: textFieldHeight, width: textFieldWidth)
        nameField.centerX(inView: contentView, topAnchor: nameLabel.bottomAnchor, paddingTop: 8)
        
        routineCountLabel.centerX(inView: contentView, topAnchor: nameField.bottomAnchor, paddingTop: 30)
        routineCountTextField.setDimensions(height: textFieldHeight, width: textFieldWidth)
        routineCountTextField.centerX(inView: contentView, topAnchor: routineCountLabel.bottomAnchor, paddingTop: 8)
        
        colorLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -(textFieldWidth/4)).isActive = true
        colorLabel.anchor(top: routineCountTextField.bottomAnchor, paddingTop: 30)
        colorButton.setDimensions(height: 70, width: 70)
        colorButton.centerX(inView: colorLabel, topAnchor: colorLabel.bottomAnchor, paddingTop: 8)
        
        dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: textFieldWidth/4).isActive = true
        dateLabel.anchor(top: routineCountTextField.bottomAnchor, paddingTop: 30)
        dateTextField.centerX(inView: dateLabel, topAnchor: dateLabel.bottomAnchor, paddingTop: 8)
        
        
        addNoteTextField.setDimensions(height: 150, width: textFieldWidth)
        addNoteTextField.centerX(inView: contentView, topAnchor: colorButton.bottomAnchor, paddingTop: 40)
        
        addButton.setDimensions(height: textFieldHeight-10, width: textFieldWidth-10)
        addButton.centerXAnchor.constraint(equalTo: self.frameLayoutGuide.centerXAnchor).isActive = true
        addButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        
        // 입력필드, 컬러버튼 모서리 둥글게
        nameField.layer.cornerRadius = textFieldHeight/2
        routineCountTextField.layer.cornerRadius = textFieldHeight/2
        colorButton.layer.cornerRadius = 35
        addNoteTextField.layer.cornerRadius = 15
        addButton.layer.cornerRadius = (textFieldHeight-10)/2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.addSubview(contentView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameField)
        contentView.addSubview(routineCountLabel)
        contentView.addSubview(routineCountTextField)
        contentView.addSubview(colorLabel)
        contentView.addSubview(colorButton)
        contentView.addSubview(dateLabel)
        contentView.addSubview(dateTextField)
        contentView.addSubview(addNoteTextField)
        contentView.addSubview(addButton)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
