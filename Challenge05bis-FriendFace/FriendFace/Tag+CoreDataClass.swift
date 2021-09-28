//
//  Tag+CoreDataClass.swift
//  FriendFace
//
//  Created by Konrad Cureau on 28/06/2021.
//
//

import Foundation
import CoreData

@objc(Tag)
public class Tag: NSManagedObject, Codable {

    enum CodingKeys: CodingKey {
        case word
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(word, forKey: .word)
    }

    required convenience public init(from decoder: Decoder) throws {
        guard let contextUserInfoKey = CodingUserInfoKey(rawValue: "context"),
              let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
              let entity = NSEntityDescription.entity(forEntityName: "Tag", in: managedObjectContext) else {
                  fatalError("Cannot decode Tag!")
              }
        self.init(entity: entity, insertInto: managedObjectContext)
        let container = try decoder.container(keyedBy: CodingKeys.self)

        do {
            word = try container.decode(String.self, forKey: .word)
        } catch {
            print(error)
        }
    }
}
