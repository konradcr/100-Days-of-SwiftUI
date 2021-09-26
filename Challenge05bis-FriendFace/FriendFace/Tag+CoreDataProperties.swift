//
//  Tag+CoreDataProperties.swift
//  FriendFace
//
//  Created by Konrad Cureau on 01/07/2021.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var word: String?
    @NSManaged public var ofUser: NSSet?
    
    public var wrappedWord: String {
        word ?? "Nature"
    }

}

// MARK: Generated accessors for ofUser
extension Tag {

    @objc(addOfUserObject:)
    @NSManaged public func addToOfUser(_ value: User)

    @objc(removeOfUserObject:)
    @NSManaged public func removeFromOfUser(_ value: User)

    @objc(addOfUser:)
    @NSManaged public func addToOfUser(_ values: NSSet)

    @objc(removeOfUser:)
    @NSManaged public func removeFromOfUser(_ values: NSSet)

}

extension Tag : Identifiable {

}
