//
//  DayOfWeekController.swift
//  HabbitManagement
//
//  Created by minii on 2021/05/27.
//

import UIKit

class DayOfWeekController: UITableViewController {
    
// MARK:- Properties
    let dayOfWeek = ["매일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"]
    // 클로져로 DatePickerController에 day값 전달
    var day = Set<Int>()
    public var dayreturnToDatePicker: ((Set<Int>) -> Void)?
    
// MARK:- View 생명주기? 부분
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "요일 선택하기"
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // 매일 버튼 활성화 유무
        isCheckEvery()
    }
}

// MARK:- 테이블뷰 설정
extension DayOfWeekController {
    // 매일 셀 체크버튼 활성화 판단
    func isCheckEvery() {
        let section = 0
        var willchecked: Bool?
        var every: Bool?
        
        for row in 1..<tableView.numberOfRows(inSection: section) {
            
            if tableView.cellForRow(at: IndexPath(row: row, section: section))?.accessoryType == UITableViewCell.AccessoryType.checkmark {
                if let inevery = every, !inevery {
                    willchecked = nil
                    break
                }
                every = true
                willchecked = true
            }
            else {
                if let inevery = every, inevery {
                    willchecked = nil
                    break
                }
                every = false
                willchecked = false
            }
        }
        
        if let checked = willchecked, checked {
            tableView.cellForRow(at: IndexPath(row: 0, section: section))?.accessoryType = .checkmark
        } else if let checked = willchecked, !checked {
            tableView.cellForRow(at: IndexPath(row: 0, section: section))?.accessoryType = .none
        }
        
        willchecked = nil
        every = nil
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        if day.contains(indexPath.row) {
            cell.accessoryType = .checkmark
        }
        
        cell.textLabel?.text = dayOfWeek[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayOfWeek.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = 0
        
        // '매일' 선택할때
        if indexPath.row == 0 {
            if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.none {
                for row in 1..<tableView.numberOfRows(inSection: section) {
                    tableView.cellForRow(at: IndexPath(row: row, section: section))?.accessoryType = .checkmark
                }
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            } else {
                for row in 1..<tableView.numberOfRows(inSection: section) {
                    tableView.cellForRow(at: IndexPath(row: row, section: section))?.accessoryType = .none
                }
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
            }
        }
        
        // '요일' 선택할때
        else {
            if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark {
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
            } else {
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }
            
            // 매일 버튼 체크유무 판단하기
            isCheckEvery()
        }
        
        // 체크된것들 day에 값 넣어주기
        var insertday = Set<Int>()
        for row in 1..<tableView.numberOfRows(inSection: section) {
            if tableView.cellForRow(at: IndexPath(row: row, section: section))?.accessoryType == UITableViewCell.AccessoryType.checkmark {
                insertday.insert(row)
            }
        }
        day = insertday
        insertday.removeAll()
        
        // DatePickerController에 값전달, 클로저형태로
        dayreturnToDatePicker?(day)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
