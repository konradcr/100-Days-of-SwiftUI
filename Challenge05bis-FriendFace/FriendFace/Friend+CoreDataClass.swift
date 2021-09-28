//
//  Friend+CoreDataClass.swift
//  FriendFace
//
//  Created by Konrad Cureau on 28/06/2021.
//
//

import Foundation
import CoreData

@objc(Friend)
public class Friend: NSManagedObject, Codable {

    enum CodingKeys: CodingKey {
        case id, name
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }

    required convenience public init(from decoder: Decoder) throws {
        guard let contextUserInfoKey = CodingUserInfoKey(rawValue: "context"),
              let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
              let entity = NSEntityDescription.entity(forEntityName: "Friend", in: managedObjectContext) else {
                  fatalError("Cannot decode Friend!")
              }
        self.init(entity: entity, insertInto: managedObjectContext)
        let container = try decoder.container(keyedBy: CodingKeys.self)

        do {
            id = try container.decode(UUID.self, forKey: .id)
            name = try container.decode(String.self, forKey: .name)
        } catch {
            print(error)
        }
    }
}
