//
//  Contact+CoreDataProperties.swift
//  WhoIMet
//
//  Created by Konrad Cureau on 10/07/2021.
//
//

import Foundation
import CoreData
import UIKit


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var photo: Data?
    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double

    public var wrappedName: String {
        name ?? "Unknow"
    }
    
    public var wrappedPhoto: Data {
        photo ?? UIImage(systemName: "person.crop.circle")!.jpegData(compressionQuality: 0.8)!
    }
    
}

extension Contact : Identifiable {

}
