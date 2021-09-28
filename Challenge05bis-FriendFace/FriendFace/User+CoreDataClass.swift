//
//  User+CoreDataClass.swift
//  FriendFace
//
//  Created by Konrad Cureau on 28/06/2021.
//
//

import Foundation
import CoreData

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}

@objc(User)
public class User: NSManagedObject, Codable {

    enum CodingKeys: CodingKey {
        case id, age, name, isActive, company, address, about, registered, email, tags, friends
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(age, forKey: .age)
        try container.encode(name, forKey: .name)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(company, forKey: .address)
        try container.encode(address, forKey: .address)
        try container.encode(about, forKey: .about)
        try container.encode(registered, forKey: .registered)
        try container.encode(email, forKey: .email)
        try container.encode(tags as! Set<Tag>, forKey: .tags)
        try container.encode(friends as! Set<Friend>, forKey: .friends)
    }

    required convenience public init(from decoder: Decoder) throws {
        guard let contextUserInfoKey = CodingUserInfoKey(rawValue: "context"),
              let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
              let entity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext) else {
                  fatalError("Cannot decode User!")
              }
        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            id = try container.decode(UUID.self, forKey: .id)
            age = try container.decode(Int16.self, forKey: .age)
            name = try container.decode(String.self, forKey: .name)
            isActive = try container.decode(Bool.self, forKey: .isActive)
            company = try container.decode(String.self, forKey: .company)
            address = try container.decode(String.self, forKey: .address)
            about = try container.decode(String.self, forKey: .about)
            registered = try container.decode(Date.self, forKey: .registered)
            email = try container.decode(String.self, forKey: .email)
            tags = NSSet(array: try container.decode([Tag].self, forKey: .tags))

            //            let tagsAsStrings = try container.decode([String].self, forKey: .tags)
            //                    var tags: Set<Tag> = Set()
            //                    for tag in tagsAsStrings {
            //                        let newTag = Tag(context: managedObjectContext)
            //                        newTag.word = tag
            //                        // Associate each tag in the set with this user
            //                        newTag.addToOfUser(self)
            //                        tags.insert(newTag)
            //                    }
            //            self.tags = tags as NSSet

            friends = NSSet(array: try container.decode([Friend].self, forKey: .friends))

        } catch {
            print(error)
        }
    }
}
