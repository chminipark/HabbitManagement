//
//  DayOfWeekController.swift
//  HabbitManagement
//
//  Created by minii on 2021/05/27.
//

import UIKit

class DayOfWeekController: UITableViewController {
    
    let dayOfWeek = ["매일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "요일 선택하기"
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell

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
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
