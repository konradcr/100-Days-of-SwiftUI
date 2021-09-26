//
//  Contact.swift
//  PeopleMet
//
//  Created by Konrad Cureau on 06/07/2021.
//

import Foundation


struct Contact: Identifiable, Codable, Comparable {
    var id = UUID()
    let photo: Data
    let name: String
    
    static func < (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.name < rhs.name
    }
}
