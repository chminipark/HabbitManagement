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
    
    // 생성
    func create(routine: RoutineInfo) {
        // 2. 먼저 Entity를 가져온다! 내가 어느 Entity에 저장해야하는지 알아야하니까..!!
        let entity = NSEntityDescription.entity(forEntityName: "Routine", in: self.context)
        
        if let entity = entity {
            // 3. NSManagedObject를 만든다.
            let routineObject = NSManagedObject(entity: entity, insertInto: self.context)
            //4. NSManagedObject에 값을 세팅해준다.
            routineObject.setValue(routine.name, forKey: "name")
            routineObject.setValue(routine.goal, forKey: "goal")
            routineObject.setValue(routine.count, forKey: "count")
            routineObject.setValue(routine.color, forKey: "color")
            routineObject.setValue(routine.day, forKey: "day")
            routineObject.setValue(routine.time, forKey: "time")
            routineObject.setValue(routine.id, forKey: "id")
            routineObject.setValue(routine.day, forKey: "day")
        }
        
        // 5. NSManagedObjectContext를 저장해준다.
        do {
            try self.context.save()
        } catch {
            print("coredata save error...")
        }
    }
    
    // 읽기
    func read() -> [Routine]? {
        do {
            let result = try self.context.fetch(Routine.fetchRequest()) as [Routine]
            return result
        } catch {
            return nil
        }
    }
    
    // 삭제, id값은 습관 생성시 만들었던 시간..
    func delete(id: Date) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Routine")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as NSDate)
        
        do {
            let test = try self.context.fetch(fetchRequest)
            if test.count == 0 {
                return
            }
            let objectToDelete = test[0] as! NSManagedObject
            self.context.delete(objectToDelete)
            try self.context.save()
        } catch {
            print("coredata delete error...")
        }
    }
    
    
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
