//
//  DatePickerController.swift
//  HabbitManagement
//
//  Created by minii on 2021/05/26.
//

import UIKit

class DatePickerController: UITableViewController {
    
// MARK: - Properties
    
    let dayKoreanList: [String] = ["월", "화", "수", "목", "금", "토", "일"]
    var time: String = "00:00"
    // 클로져 형태로 DayOfWeekController에서 day값 받아오기
    var day: Array<Int> = []
    // 클로져 형태로 AddHabbitcontroller에 day, time 값 넘겨주기
    public var timereturnToAddHabbit: ((String) -> Void)?
    public var dayreturnToAddHabbit: ((Array<Int>) -> Void)?
    
    // 고정(정적) 셀
    let dayCell: UITableViewCell = {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        cell.textLabel?.text = "반복"
        cell.accessoryType = .disclosureIndicator
        cell.detailTextLabel?.text = "좀떠라제발쫌쪼몾ㅁ"
        cell.detailTextLabel?.textColor = .lightGray
        return cell
    }()
    
    // 시간
    let hour: Array<Int> = {
        var number = [Int]()
        number.append(contentsOf: stride(from: 0, through: 23, by: 1))
        return number
    }()
    
    // 분
    let minute: Array<Int> = {
        var number = [Int]()
        number.append(contentsOf: stride(from: 0, through: 59, by: 1))
        return number
    }()
    
    let pickerView = UIPickerView()
    
    // 오전, 오후 일단 헷갈려서 주석처리..
    //    let meridiem: [String] = ["AM", "PM"]

// MARK:- View 생명주기? 부분
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "알람 추가하기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .done, target: self, action: #selector(addDate))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(dismissController))
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 350))
        tableView.tableHeaderView = header
        header.backgroundColor = .white
        
        pickerView.delegate = self
        header.addSubview(pickerView)
        pickerView.anchor(top: header.topAnchor, bottom: header.bottomAnchor)
        pickerView.widthAnchor.constraint(equalTo: header.widthAnchor).isActive = true
        pickerView.centerX(inView: header)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        // detailTextLabel에 선택된 day값 넣어주기
        day.sort()
        var korean = ""
        for i in day {
            korean += dayKoreanList[i-1]
        }
        self.dayCell.detailTextLabel?.text = korean
        
        // 피커뷰 초기값 설정
        if let component1 = Int(time.dropLast(3)) {
            self.pickerView.selectRow(component1, inComponent: 0, animated: true)
        }
        if let component2 = Int(time.dropFirst(3)) {
            self.pickerView.selectRow(component2, inComponent: 1, animated: true)
        }
    }
}

// MARK:- 추가, 취소버튼 설정
extension DatePickerController {
    // 취소하기
    @objc func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 추가하기
    @objc func addDate() {
        timereturnToAddHabbit?(time)
        dayreturnToAddHabbit?(day)
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK:- 테이블뷰 설정
extension DatePickerController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "date picker!"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.row) {
        case 0: return self.dayCell
        case 1: return UITableViewCell.init()
        default: fatalError("Unknown row in section 0")
        }
    }
    
// MARK: 반복 셀 터치시
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.row) {
        
        case 0:
            let vc = DayOfWeekController()
            // DayofWeek에서 선택된 값 들고오기
            vc.dayreturnToDatePicker = { day in
                self.day = Array(day)
            }
            // DayOfWeek로 넘어갈때 DayOfWeek의 day 값이 초기화되므로 프로퍼티로 직접 접근해서 간단하게 다시 넘겨줌
            vc.day = Set(self.day)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 1:
            print(self.time)
            
        default: fatalError("error???")
            
        }
    }
}

// MARK:- 헤더 피커뷰 설정
extension DatePickerController: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return hour.count
        case 1: return minute.count
        //        case 2: return meridiem.count
        default:
            fatalError()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: return String(hour[row])
        case 1: return String(minute[row])
        //        case 2: return meridiem[row]
        default:
            fatalError()
        }
    }
    
    // 피커 선택시 alarmTime에 데이터 넣어주기
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            if row < 10 {
                self.time = "0\(row)" + String(self.time.dropFirst(2))
            } else {
                self.time = String(row) + String(self.time.dropFirst(2))
            }
        } else if component == 1 {
            if row < 10 {
                self.time = String(self.time.dropLast(2)) + "0\(row)"
            } else {
                self.time = String(self.time.dropLast(2)) + String(row)
            }
        }
    }
}
