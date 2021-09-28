//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Konrad Cureau on 25/06/2021.
//

import SwiftUI

struct FilteredList: View {
    var fetchRequest: FetchRequest<Singer>
    init(filter: String) {
        fetchRequest = FetchRequest<Singer>(
            entity: Singer.entity(),
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Singer.lastName, ascending: true),
                NSSortDescriptor(keyPath: \Singer.firstName, ascending: true)
            ],
            predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter)
        )
    }

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
}
