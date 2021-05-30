//
//  ProfileController.swift
//  HabbitManagement
//
//  Created by 강호성 on 2021/05/22.
//

import UIKit

class ProfileController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    var settingOption: SettingsOption?
    var section: Section?
    var settingSwitch: SettingsSwitchOption?
    var settingType: SettingsOptionType?
    
    var user: User? {
        didSet { tableView.reloadData() }
    }
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
        table.register(SwitchCell.self, forCellReuseIdentifier: SwitchCell.identifier)
        return table
    }()
    
    var models = [Section]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        fetchUser()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    // MARK: - API
    
    func fetchUser() {
        UserService.fetchUser { user in
            self.user = user
            self.navigationItem.title = user.username
        }
    }
    
    
    
    // MARK: - Helpers
    
    func configure() {
        models.append(Section(title: "", options: [
            .switchCell(model: SettingsSwitchOption(title: "Switch", handler: {
                print("switch")
            }, isOn: true))
        ]))
        
        models.append(Section(title: "", options: [
            .staticCell(model: SettingsOption(title: "A") {
                print("A")
            }),
            .staticCell(model: SettingsOption(title: "B") {
                print("B")
            }),
            .staticCell(model: SettingsOption(title: "C") {
                print("C")
            }),
        ]))
        
        models.append(Section(title: "", options: [
            .staticCell(model: SettingsOption(title: "D") {
                print("D")
            }),
            .staticCell(model: SettingsOption(title: "E") {
                print("E")
            }),
            .staticCell(model: SettingsOption(title: "F") {
                print("F")
            }),
        ]))
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // section 자체가 될 model을 가져온다
        let section = models[section]
        
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as? ProfileCell else { return UITableViewCell() }
            
            cell.configure(with: model)
            return cell
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchCell.identifier, for: indexPath) as? SwitchCell else { return UITableViewCell() }
            
            cell.configure(with: model)
            return cell
        }
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        switch type.self {
        case .staticCell(let model):
            model.handler()
        case .switchCell(let model):
            model.handler()
        }
    }
}
