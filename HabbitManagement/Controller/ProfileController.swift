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
    
    private var user: User
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
        table.register(SwitchCell.self, forCellReuseIdentifier: SwitchCell.identifier)
        return table
    }()
    
    var models = [Section]()
    
    // MARK: - Lifecycle
    
    // 사용자 개체로 초기화
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    // MARK: - Helpers
    
    func configure() {
        navigationItem.title = user.username
        
        models.append(Section(title: "", options: [
            .staticCell(model: SettingsOption(title: "About") {
                let controller = InformationController()
                self.navigationController?.pushViewController(controller, animated: true)

            }),
            .staticCell(model: SettingsOption(title: "공지사항") {
                let controller = NoticeController()
                self.navigationController?.pushViewController(controller, animated: true)
            })
        ]))
        
        models.append(Section(title: "", options: [
            .staticCell(model: SettingsOption(title: "오류 제보하기") {
                let controller = ErrorReportController()
                controller.delegate = self
                self.navigationController?.pushViewController(controller, animated: true)
            }),
            .staticCell(model: SettingsOption(title: "의견 보내기") {
                let controller = FeedbackController()
                controller.delegate = self
                self.navigationController?.pushViewController(controller, animated: true)
            })
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

    // MARK: - FeedbackControllerDelegate,ErrorReportControllerDelegate

extension ProfileController: FeedbackControllerDelegate, ErrorReportControllerDelegate {
    func DidSendMessage(_ controller: FeedbackController) {
        navigationController?.popViewController(animated: true)
        showMessage(withTitle: "제출 성공", message: "보내주신 의견을 성공적으로 보냈습니다.")
    }
    
    func DidSendMessage(_ controller: ErrorReportController) {
        navigationController?.popViewController(animated: true)
        showMessage(withTitle: "제출 성공", message: "발견하신 오류내용을 성공적으로 보냈습니다. 신속히 수정하겠습니다.")
    }
}

