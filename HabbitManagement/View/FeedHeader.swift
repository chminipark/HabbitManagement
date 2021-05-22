//
//  FeedHeader.swift
//  HabbitManagement
//
//  Created by 강호성 on 2021/05/22.
//

import UIKit

class FeedHeader: UICollectionViewCell {
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemYellow
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

