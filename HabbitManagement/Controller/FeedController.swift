//
//  FeedController.swift
//  HabbitManagement
//
//  Created by 강호성 on 2021/05/21.
//

import UIKit
import FSCalendar
import Firebase

private let reuseIdentifier = "FeedCell"

class FeedController: UITableViewController {
    
    // MARK: - Properties
        
    var calendar = FSCalendar()
    let dateFormatter = DateFormatter()
    
    private let notificationPublisher = NotificationController()
    
    var routineList: [Routine]?
    var key: String?
    var datecolordic: [String: [UIColor]] = [:]
    
    let sampledatelist = ["2021-06-09","2021-06-10"]
    let samplecolor1 = [UIColor.systemRed, UIColor.systemBlue, UIColor.systemGreen]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(FeedCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "alarm", style: .plain, target: self, action: #selector(Tap))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "cancel_shadow"), style: .plain, target: self, action: #selector(handleLogout))
        
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 350))
        tableView.tableHeaderView = header
        //        header.backgroundColor = .systemOrange
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // 캘린더 추가하기
        header.addSubview(calendar)
        calendar.anchor(top: header.topAnchor, bottom: header.bottomAnchor)
        calendar.widthAnchor.constraint(equalTo: header.widthAnchor).isActive = true
        calendar.centerX(inView: header)
        
        // 캘린더 헤더 설정
        calendar.headerHeight = 50
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 24)
        
        // 캘린더 기본 색상 지정
        calendar.appearance.titleSelectionColor = .black
        calendar.appearance.subtitleSelectionColor = .black
        calendar.appearance.titleTodayColor = .black
        calendar.appearance.subtitleTodayColor = .black
        calendar.appearance.eventDefaultColor = .white
        calendar.appearance.todayColor = .white
        
        // 캘린더 weekday name 설정
        calendar.locale = Locale(identifier: "ko_KR")

        calendar.delegate = self
        calendar.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.routineList = DataManager.shared.read()
        self.datecolordic = [:]
        datecolor()
        DispatchQueue.main.async {
            self.calendar.reloadData()
        }
        print(self.datecolordic)
    }
    
    // MARK: - Actions
    
    // 캘린더에 컬러 띄우기위해 datecolordic에 routinelist.goallist와 color 값 받아서 딕셔너리로 정렬
    func datecolor() {
        guard let routinelist = self.routineList else {
            return
        }
        
        for i in routinelist {
            if let goallist = i.goallist,
               goallist.count != 0 {
                for j in goallist {
                    if let color = i.color,
                       let uicolor = UIColor.color(data: color) {
                        if self.datecolordic[j] == nil {
                            self.datecolordic.updateValue([uicolor] , forKey: j)
                        }
                        else if self.datecolordic[j] != nil {
                            if let uicolorlist = self.datecolordic[j] {
                                
                                //                            uicolorlist = Set(arrayLiteral: uicolorlist)
                                //                            uicolorlist?.insert(uicolor)
                                if !uicolorlist.contains(uicolor) {
                                    var append = uicolorlist
                                    append.append(uicolor)
                                    self.datecolordic.updateValue(append, forKey: j)
                                }
                            }
                        }
                }
            }
        }
    }
    }
    
    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
            let controller = LoginController()
            controller.delegate = self.tabBarController as? MainTabController
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        } catch {
            print("DEBUG: Failed to sign out")
        }
    }
    
    @objc func Tap() {
        notificationPublisher.sendNotification(title: "Test Title", body: "Test Body", badge: 1, delayInterval: nil)
    }
}
    // MARK: - HeaderInSection

extension FeedController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List of Today's Habits"
    }
}

extension FeedController: FSCalendarDelegateAppearance, FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        
        let key = self.dateFormatter.string(from: date)
        
        if self.datecolordic[key] != nil {
            let uicolor = self.datecolordic[key]
            return uicolor
        }
        
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let key = self.dateFormatter.string(from: date)
        
        if self.datecolordic[key] != nil {
            if let uicolor = self.datecolordic[key] {
                return uicolor.count
            }
        }
        
        return 0
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let key = self.dateFormatter.string(from: date)
        self.key = key
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension FeedController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        
        cell.backgroundColor = .white
        
        guard let routinelist = self.routineList,
              let key = self.key else {
            return cell
        }
        
        if let name = routinelist[indexPath.row].name {
            cell.textLabel?.text = name
            if let datecountgoal = routinelist[indexPath.row].datecountgoal?[key],
               let celltext = cell.textLabel?.text {
                let text = "\(celltext),    \(datecountgoal)"
                cell.textLabel?.text = text
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let routinelist = self.routineList else {
            return 0
        }
        
        return routinelist.count
    }
}
