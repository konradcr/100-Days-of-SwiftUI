//
//  Result+CoreDataProperties.swift
//  RollDice
//
//  Created by Konrad Cureau on 18/07/2021.
//
//

import Foundation
import CoreData

extension Result {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Result> {
        return NSFetchRequest<Result>(entityName: "Result")
    }

    @NSManaged public var id: UUID
    @NSManaged public var nbrOfDice: Int16
    @NSManaged public var totalResult: Int16
    @NSManaged public var dice: NSSet?

    var wrappedTotalResult: Int {
        Int(totalResult)
    }

    var wrappedNbrOfDice: Int {
        Int(nbrOfDice)
    }

    var diceArray: [Die] {
        let set = dice as? Set<Die> ?? []
        let array = set.sorted {(firstDie, secondDie) -> Bool in
            firstDie.wrappedDieResult > secondDie.wrappedDieResult
        }
        return array
    }
}

// MARK: Generated accessors for dice
extension Result {

    @objc(addDiceObject:)
    @NSManaged public func addToDice(_ value: Die)

    @objc(removeDiceObject:)
    @NSManaged public func removeFromDice(_ value: Die)

    @objc(addDice:)
    @NSManaged public func addToDice(_ values: NSSet)

    @objc(removeDice:)
    @NSManaged public func removeFromDice(_ values: NSSet)

}

extension Result: Identifiable {

}
