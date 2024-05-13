//
//  OwO+CoreDataProperties.swift
//  MATHEMATIK
//
//  Created by PEDRO on 13/5/24.
//
//

//CREATED WITH NSManagedObject Subclass
import Foundation
import CoreData


extension OwO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OwO> {
        return NSFetchRequest<OwO>(entityName: "OwO")
    }

    @NSManaged public var score: Int32
    @NSManaged public var timeSurvived: Int32

}

extension OwO : Identifiable {

}
