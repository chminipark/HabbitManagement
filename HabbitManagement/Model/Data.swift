//
//  Data.swift
//  HabbitManagement
//
//  Created by minii on 2021/05/29.
//

import Foundation
import UIKit

struct RoutineInfo {
    let name: String
    let goal: Int
    let color: Data
    let day: [Int]
    let time: String
    var count: Int
    let id: Date
}

// UIColor CoreData에 저장하기 위해 변환
extension UIColor {
    class func color(data:Data) -> UIColor? {
        return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
    }
    
    func encode() -> Data? {
        return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
    }
}

struct CalendarInfo {
    let id: Date
    let datecountgoal: [String: String]
    let goallist: [String]
}
