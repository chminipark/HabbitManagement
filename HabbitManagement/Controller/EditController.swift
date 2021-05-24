//
//  EditController.swift
//  HabbitManagement
//
//  Created by 강호성 on 2021/05/22.
//

import UIKit

class EditController: UIViewController {
    // MARK: - Test Case(Sample)
    struct Sample {
        var name: String
        var count: Int
        var goal: Int
    }
    
    fileprivate let testCase: [Sample] = [Sample(name: "습관1", count: 1, goal: 5),
                              Sample(name: "습관2", count: 2, goal: 3)]
    
    // MARK: - Properties
    var habbitCollectionView: UICollectionView?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        habbitCollectionView?.dataSource = self
    }
    
    // MARK: - Actions
    
    @objc func TapAdd() {
        let vc = AddHabbitController()
//        let nav = UINavigationController(rootViewController: vc)
//        present(nav, animated: true, completion: nil)
        
//        self.navigationController?.navigationBar.topItem?.title = "습관 만들기"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Methods
    
    func configureUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus_unselected"), style: .plain, target: self, action: #selector(TapAdd))
        
        addCollectionView()
    }
    
    func addCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        let size = (view.frame.width - 120) / 2
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 40, bottom: 20, right: 40)
        layout.itemSize = CGSize(width: size, height: size)
        
        habbitCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        habbitCollectionView?.register(HabbitCell.self, forCellWithReuseIdentifier: "habbitCell")
        habbitCollectionView?.backgroundColor = .white
        
        view.addSubview(habbitCollectionView ?? UICollectionView())
        habbitCollectionView?.reloadData()
    }
}

extension EditController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testCase.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let collectionView = habbitCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "habbitCell", for: indexPath) as! HabbitCell
            
            cell.nameLable.text = self.testCase[indexPath.row].name
            cell.countLabel.text = String(self.testCase[indexPath.row].count)
            cell.goalLabel.text = String(self.testCase[indexPath.row].goal)

            cell.contentView.layer.cornerRadius = 15
            cell.contentView.layer.borderWidth = 1.0
            cell.contentView.layer.borderColor = UIColor.red.cgColor
            cell.contentView.layer.masksToBounds = true
            
            cell.layer.shadowColor = UIColor.gray.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            cell.layer.shadowRadius = 2.0
            cell.layer.shadowOpacity = 1.0
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
            
            cell.layer.cornerRadius = 15
            cell.backgroundColor = .white

            
            return cell
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    
}
