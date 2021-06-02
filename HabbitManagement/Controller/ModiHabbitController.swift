//
//  ModiHabbitController.swift
//  HabbitManagement
//
//  Created by minii on 2021/05/31.
//

import UIKit

class ModiHabbitController: UIViewController {
    
    let addView = AddView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "수정하기"
        
        view.addSubview(addView)
        // addView 레이아웃 설정
        addView.frame = view.bounds
        addView.setConstraint()
        // scrollView 세로길이 동적 구하기
        // AddView에 구성요소들 추가될때마다 제일 마지막 것으로 넣어주기
        addView.bottomAnchor.constraint(equalTo: addView.addNoteTextField.bottomAnchor, constant: 500).isActive = true
        
        // addNoteTextField placeholder 셋팅
        placeholderSetting()
        
        // delegate 설정, 엔터키 탭키기능
        addView.nameField.delegate = self
        addView.routineCountTextField.delegate = self
        addView.addNoteTextField.delegate = self
        
        // 스크롤뷰에서 탭하면 키보드 내려감
        setScrollViewTap()
        // delegate 설정, 스크롤뷰에서 스크롤하면 키보드 내려감
        addView.delegate = self
        
        // 컬러버튼 셋팅
        setColorButtonTap()
        
        // dateTextField 터치시 DatePickerController 호출
        setdateTextFieldTap()
        
        // 추가하기버튼 셋팅
        addView.addButton.addTarget(self, action: #selector(addButtonTap), for: .touchUpInside)
        
        // 취소버튼 추가
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(didTapcancelButton))
    }
    
    // 취소 버튼 클릭시
    @objc func didTapcancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 스크롤뷰에서 탭하면 키보드 내려감
    func setScrollViewTap() {
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(scrollViewTap))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        self.addView.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    @objc func scrollViewTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    // 컬러버튼 제스쳐 추가후 colorpicker 연결
    func setColorButtonTap() {
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(colorButtonTap))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        self.addView.colorButton.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    @objc func colorButtonTap() {
        presentPicker()
    }
    
    func setdateTextFieldTap() {
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dateTexFieldTap))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        self.addView.dateTextField.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    @objc func dateTexFieldTap() {
        let vc = DatePickerController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
    
    // 저장하기
    @objc func addButtonTap() {
        // 키보드 내리기
        addView.nameField.resignFirstResponder()
        addView.routineCountTextField.resignFirstResponder()
        addView.addNoteTextField.resignFirstResponder()
        
        guard let name = addView.nameField.text,
              let goal = addView.routineCountTextField.text,
              !name.isEmpty,
              !goal.isEmpty else {
            alert(message: "이름과 횟수를 입력해주세요")
            return
        }
        
        guard let isintgoal = Int(goal),
              let datacolor = addView.colorButton.backgroundColor?.encode()
              else {
            print("not int and nocolor!!!")
            return
        }
        
        let routine = RoutineInfo(name: name, goal: isintgoal, color: datacolor, day: nil, time: nil, count: 0, id: Date())
        
        DataManager.shared.create(routine: routine)
        reset()
        alert(message: "저장되었습니다!")
    }
    
    func alert(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "돌아가기", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func reset() {
        addView.nameField.text = nil
        addView.routineCountTextField.text = nil
        addView.colorButton.backgroundColor = .systemPink
        addView.addButton.backgroundColor = .systemPink
    }
    
}

// textview placeholder
extension ModiHabbitController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "설명을 입력해주세요..."
            textView.textColor = UIColor.lightGray
        }
    }
    
    func placeholderSetting() {
        addView.addNoteTextField.delegate = self
        addView.addNoteTextField.text = "설명을 입력해주세요..."
        addView.addNoteTextField.textColor = .lightGray
    }
}

// 엔터키 누르면 탭키기능, 화면터치시 키보드 내리기
extension ModiHabbitController: UITextFieldDelegate {
    // 엔터키 누르면 탭키기능
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == addView.nameField {
            addView.routineCountTextField.becomeFirstResponder()
        }
//        else if textField == addView.routineCountTextField {
//            addView.addNoteTextField.becomeFirstResponder()
//        }
//        else if textField == addView.addNoteTextField {
//            // 추가하기 버튼 탭으로 변경하기
//            addView.addNoteTextField.resignFirstResponder()
//        }
        return true
    }
    
}

// 스크롤뷰에서 스크롤하면 키보드 내려감
extension ModiHabbitController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

// ColorButton 색상 변경
extension ModiHabbitController: UIColorPickerViewControllerDelegate {
    func presentPicker() {
        let vc = UIColorPickerViewController()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        DispatchQueue.main.async {
            self.addView.colorButton.backgroundColor = viewController.selectedColor
            self.addView.addButton.backgroundColor = viewController.selectedColor
        }
    }
}
