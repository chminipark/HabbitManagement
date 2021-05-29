//
//  DataManager.swift
//  HabbitManagement
//
//  Created by minii on 2021/05/29.
//

import UIKit
import CoreData

class DataManager {
    // single ton
    static var shared = DataManager()
    
    /*
     1. NSManagedObjectContext를 가져온다.
     2. 먼저 Entity를 가져온다! 내가 어느 Entity에 저장해야하는지 알아야하니까..!!
     3. NSManagedObject를 만든다.
     4. NSManagedObject에 값을 세팅해준다.
     5. NSManagedObjectContext를 저장해준다.
     */
    
    
    // CoreData 설정
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // 1. NSManagedObjectContext를 가져온다.
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
}
