//
//  Die+CoreDataProperties.swift
//  RollDice
//
//  Created by Konrad Cureau on 18/07/2021.
//
//

import Foundation
import CoreData


extension Die {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Die> {
        return NSFetchRequest<Die>(entityName: "Die")
    }

    @NSManaged public var id: UUID
    @NSManaged public var dieResult: Int16
    @NSManaged public var nbrOfSide: Int16
    @NSManaged public var mainResult: Result?
    
    var wrappedNbrOfSide: Int {
        Int(nbrOfSide)
    }
    
    var wrappedDieResult: Int {
        Int(dieResult)
    }

}

extension Die : Identifiable {

}
