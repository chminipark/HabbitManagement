//
//  EditController.swift
//  HabbitManagement
//
//  Created by 강호성 on 2021/05/22.
//

import UIKit

class EditController: UIViewController {
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Actions
    
    @objc func TapAdd() {
        let vc = AddHabbitController()
//        let nav = UINavigationController(rootViewController: vc)
//        present(nav, animated: true, completion: nil)
        
//        self.navigationController?.navigationBar.topItem?.title = "습관 만들기"
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .systemBlue
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus_unselected"), style: .plain, target: self, action: #selector(TapAdd))
    }
}
