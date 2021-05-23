//
//  AddHabbitController.swift
//  HabbitManagement
//
//  Created by 강호성 on 2021/05/22.
//

import UIKit

class AddHabbitController: UIViewController {
    
    let addView = AddView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "습관 만들기"
        
        view.addSubview(addView)
        // addView 레이아웃 설정
        addView.frame = view.bounds
        addView.setConstraint()
        // scrollView 세로길이 동적 구하기
        // AddView에 구성요소들 추가될때마다 제일 마지막 것으로 넣어주기
        addView.bottomAnchor.constraint(equalTo: addView.addNoteTextField.bottomAnchor, constant: 500).isActive = true
    }
}

extension AddHabbitController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "내용을 입력해주세요."
            textView.textColor = UIColor.lightGray
        }
    }
}
