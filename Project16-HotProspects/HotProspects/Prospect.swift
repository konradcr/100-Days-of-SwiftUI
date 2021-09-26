//
//  Prospect.swift
//  HotProspects
//
//  Created by Konrad Cureau on 13/07/2021.
//

import SwiftUI

class Prospect: Identifiable, Codable, Comparable {
    
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    
    static func < (lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.name < rhs.name
    }
    static func == (lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.id == rhs.id
    }
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    static let saveKey = "SavedData"
    static let fileName = saveKey + ".txt"
    
    init() {
        //        This code is used if you want to read it from UserDefault
        
        //        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
        //            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
        //                self.people = decoded
        //                return
        //            }
        //        }
        //
        //        self.people = []
        self.people = loadData(file: Self.fileName) ?? []
    }
    
    private func save() {
        //        This code is used if you want to save it to UserDefault
        
        //        if let encoded = try? JSONEncoder().encode(people) {
        //            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        //        }
        saveData(of: people, to: Self.fileName)
    }
    
    
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
