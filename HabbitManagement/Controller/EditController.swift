//
//  EditController.swift
//  HabbitManagement
//
//  Created by 강호성 on 2021/05/22.
//

import UIKit

class EditController: UIViewController {
    // MARK: - Test Case(Sample)
//    struct Sample {
//        var name: String
//        var count: Int
//        var goal: Int
//    }
    
//    fileprivate var testCase: [Sample] = [Sample(name: "습관1", count: 1, goal: 5),
//                              Sample(name: "습관2", count: 2, goal: 3),
//                              Sample(name: "습관3", count: 0, goal: 1)]
//    let layerColors: [UIColor] = [.red, .orange, .yellow, .green, .blue, .purple]
    
    var routineList: [Routine]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        routineList = DataManager.shared.read()
        DispatchQueue.main.async {
            self.habbitCollectionView?.reloadData()
        }
    }
    
    // MARK: - Properties
    var habbitCollectionView: UICollectionView?
    
    var isEditMode: Bool = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        habbitCollectionView?.dataSource = self
        habbitCollectionView?.delegate = self
        
    }
    
    // MARK: - Actions
    
    @objc func TapAdd() {
        let vc = AddHabbitController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func editPressed() {
        isEditMode = isEditMode ? false : true
        print(isEditMode)
        habbitCollectionView?.reloadData()
    }
    
    // 습관 수정
    @IBAction func cellEditButtonPressed(sender: CustomTapGestureRecognizer) {
        guard let index = sender.customValue,
              let routineList = routineList
              else {
            return
        }
        
        let rootvc = ModiHabbitController()
        let navvc = UINavigationController(rootViewController: rootvc)
        
        // ModiHabbitController에 프로퍼티 형태로 값 전달
        rootvc.addView.nameField.text = routineList[index].name
        rootvc.addView.routineCountTextField.text = String(routineList[index].goal)
        
        present(navvc, animated: true)
        
    }
    
//     습관 삭제
    @IBAction func cellRemoveButtonPressed(sender: CustomTapGestureRecognizer) {
        guard let index = sender.customValue,
              let routineList = routineList
              else {
            return
        }
        if let id = routineList[index].id {
            DataManager.shared.delete(id: id)
        }
        self.routineList = DataManager.shared.read()
        DispatchQueue.main.async {
            self.habbitCollectionView?.reloadData()
        }
    }
    
    // MARK: - Methods
    
    func configureUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus_unselected"), style: .plain, target: self, action: #selector(TapAdd))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editPressed))
        
        addCollectionView()
    }
    
    func addCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        let size = (view.frame.width - 120) / 2
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 40, bottom: 20, right: 40)
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: size, height: size)
        
        habbitCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        habbitCollectionView?.register(HabbitCell.self, forCellWithReuseIdentifier: "habbitCell")
        habbitCollectionView?.backgroundColor = .white
        
        view.addSubview(habbitCollectionView ?? UICollectionView())
        habbitCollectionView?.reloadData()
    }
}

// MARK: - UICollectionVIewDataSource & Delegate Methods
extension EditController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return testCase.count
        return routineList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let collectionView = habbitCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "habbitCell", for: indexPath) as! HabbitCell
            
            // cell에 data 넣어주기
            guard let routineList = routineList else {
                return cell
            }
            cell.nameLabel.text = routineList[indexPath.row].name
            cell.countLabel.text = String(routineList[indexPath.row].count)
            cell.goalLabel.text = String(routineList[indexPath.row].goal)
            if let color = routineList[indexPath.row].color {
                cell.contentView.layer.borderColor = UIColor.color(data: color)?.cgColor
            }
            
            cell.contentView.layer.cornerRadius = 15
            cell.contentView.layer.borderWidth = 2.0
            cell.contentView.layer.masksToBounds = true

            cell.layer.shadowColor = UIColor.gray.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 4.0)
            cell.layer.shadowRadius = 2.0
            cell.layer.shadowOpacity = 1.0
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
            
            cell.layer.cornerRadius = 15
            cell.backgroundColor = .white
            
            let editButton = UIButton()
            editButton.setBackgroundImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
            editButton.tintColor = .systemGreen
            
            // CustomTapGesture 만들어서 선택한 셀 index값 넘겨주기
            let editGesture = CustomTapGestureRecognizer(target: self, action: #selector(self.cellEditButtonPressed(sender:)))
            editGesture.customValue = indexPath.row
            editButton.addGestureRecognizer(editGesture)
            
            editButton.tag = 1
            cell.addSubview(editButton)
            editButton.anchor(top: cell.topAnchor,
                              left: cell.leftAnchor,
                              paddingTop: -8,
                              paddingLeft: -8,
                              width: 32,
                              height: 32)
            
            let removeButton = UIButton()
            removeButton.setBackgroundImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
            removeButton.tintColor = .systemRed

            // CustomTapGesture 만들어서 선택한 셀 index값 넘겨주기
            let removeGesture = CustomTapGestureRecognizer(target: self, action: #selector(self.cellRemoveButtonPressed(sender:)))
            removeGesture.customValue = indexPath.row
            removeButton.addGestureRecognizer(removeGesture)
            
            
            removeButton.tag = 2
            cell.addSubview(removeButton)
            removeButton.anchor(top: cell.topAnchor,
                                right: cell.rightAnchor,
                                paddingTop: -8,
                                paddingRight: -8,
                                width: 32,
                                height: 32)
            
            // 수정 모드일 때, 수정 버튼 출력 / 숨김
            // 해당 버튼을 특정할 수 있는 방법이 안보여서, for문을 통해 subviews에서 찾아서 사용해야한다.
            if isEditMode {
                for i in cell.subviews {
                    if i.tag == 1 || i.tag == 2 {
                        i.isHidden = false
                    }
                }
                cell.jiggleCells()
            } else {
                for i in cell.subviews {
                    if i.tag == 1 || i.tag == 2 {
                        i.isHidden = true
                    }
                }
                cell.stopJiggling()
            }
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let routineList = routineList else {
            return
        }
        
        routineList[indexPath.row].count += 1
        
        DispatchQueue.main.async {
            collectionView.reloadData()
        }
    }
}


class CustomTapGestureRecognizer: UITapGestureRecognizer {
    var customValue: Int?
}
