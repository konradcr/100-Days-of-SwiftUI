//
//  User+CoreDataProperties.swift
//  FriendFace
//
//  Created by Konrad Cureau on 28/06/2021.
//
//

import Foundation
import CoreData
import SwiftUI


extension User {
    
    
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID
    @NSManaged public var age: Int16
    @NSManaged public var name: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var company: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date
    @NSManaged public var email: String?
    @NSManaged public var tags: NSSet?
    @NSManaged public var friends: NSSet?
    
    
    
    public var wrappedName: String {
        name ?? "Konrad"
    }
    
    public var initialsName: String {
        wrappedName.components(separatedBy: " ").reduce("") {
            ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }
    }
    
    public var wrappedCompany: String {
        company ?? "Apple"
    }
    
    public var wrappedAddress: String {
        address ?? "France"
    }
    
    public var wrappedAbout: String {
        about ?? "I would like to become an iOS dev"
    }
    
    public var wrappedEmail: String {
        email ?? "@icloud.com"
    }

    public var tagsArray: [Tag] {
        let set = tags as? Set<Tag> ?? []
        return set.sorted {
            $0.wrappedWord < $1.wrappedWord
        }
    }

    var formattedRegisteredDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: registered)
    }
    
    public var friendsArray: [Friend] {
        let set = friends as? Set<Friend> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    
    public var statut: String {
        if isActive {
            return "Online"
        } else {
            return "Offline"
        }
    }
    
    var colorUser: Color {
        switch age {
        case 0..<21:
            return .blue
        case 21..<25:
            return .yellow
        case 25..<28:
            return .orange
        case 28..<32:
            return .pink
        case 32..<35:
            return .red
        case 35..<40:
            return .purple
        case 40..<100:
            return .green
        default:
            return .black
        }
    
    }
    
    var statutColor: Color {
        if isActive {
            return .green
        } else {
            return .red
        }
    }
    
    
    
}

// MARK: Generated accessors for tags
extension User {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: Tag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: Tag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}

// MARK: Generated accessors for friends
extension User {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: Friend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: Friend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension User : Identifiable {

}
