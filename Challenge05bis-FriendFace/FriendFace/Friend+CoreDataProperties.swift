//
//  Friend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Konrad Cureau on 29/06/2021.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String?
    @NSManaged public var ofUser: NSSet?
    
    public var wrappedName: String {
        name ?? "Konrad"
    }

}

// MARK: Generated accessors for ofUser
extension Friend {

    @objc(addOfUserObject:)
    @NSManaged public func addToOfUser(_ value: User)

    @objc(removeOfUserObject:)
    @NSManaged public func removeFromOfUser(_ value: User)

    @objc(addOfUser:)
    @NSManaged public func addToOfUser(_ values: NSSet)

    @objc(removeOfUser:)
    @NSManaged public func removeFromOfUser(_ values: NSSet)

}

extension Friend : Identifiable {

}
