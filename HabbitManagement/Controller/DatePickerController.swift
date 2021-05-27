//
//  DatePickerController.swift
//  HabbitManagement
//
//  Created by minii on 2021/05/26.
//

import UIKit

//private let reuseIdentifier = "DatePickerCell"

class DatePickerController: UITableViewController {
    
    let dayCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "반복"
        cell.accessoryType = .disclosureIndicator
        return cell
    }()
    
    let hour: Array<Int> = {
        var number = [Int]()
        number.append(contentsOf: stride(from: 1, through: 12, by: 1))
        return number
    }()
    
    let minute: Array<Int> = {
        var number = [Int]()
        number.append(contentsOf: stride(from: 0, through: 59, by: 1))
        return number
    }()
    
    let meridiem: [String] = ["AM", "PM"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "알람 추가하기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .done, target: self, action: #selector(addDate))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(dismissController))
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 350))
        tableView.tableHeaderView = header
        header.backgroundColor = .white
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        header.addSubview(pickerView)
        pickerView.anchor(top: header.topAnchor, bottom: header.bottomAnchor)
        pickerView.widthAnchor.constraint(equalTo: header.widthAnchor).isActive = true
        pickerView.centerX(inView: header)
    }
    
    @objc func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addDate() {
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "date picker!"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.row) {
        case 0: return self.dayCell
        default: fatalError("Unknown row in section 0")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.row) {
        case 0:
            let vc = DayOfWeekController()
            self.navigationController?.pushViewController(vc, animated: true)
        default: fatalError("error???")
        }
    }
}

extension DatePickerController: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return hour.count
        case 1: return minute.count
        case 2: return meridiem.count
        default:
            fatalError()
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: return String(hour[row])
        case 1: return String(minute[row])
        case 2: return meridiem[row]
        default:
            fatalError()
        }
    }
}
