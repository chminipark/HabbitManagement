//
//  FeedController.swift
//  HabbitManagement
//
//  Created by 강호성 on 2021/05/21.
//

import UIKit

private let reuseIdentifier = "FeedCell"

class FeedController: UITableViewController {
    
    // MARK: - Properties
    
        
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(FeedCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.backgroundColor = .white
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 350))
        tableView.tableHeaderView = header
        header.backgroundColor = .systemOrange
}
    
    // MARK: - Actions
    
    // MARK: - Helpers
    
}

extension FeedController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List of Today's Habits"
    }
    
//    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 30.0
//    }
//
//    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        return "This is Sections Footer"
//    }
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return data.count
//    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data[section].count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
//
//      cell.textLabel?.text = data[indexPath.section]
//        cell.backgroundColor = .systemBlue
//        return cell
//    }
//
}

