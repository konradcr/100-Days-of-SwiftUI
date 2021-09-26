//
//  User.swift
//  UsersNetWork
//
//  Created by Konrad Cureau on 25/06/2021.
//

import Foundation
import SwiftUI

struct Users: Codable {
    let users: [User]
}



struct User: Codable, Identifiable {
    var id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
    
    struct Friend: Codable, Identifiable {
        var id: UUID
        let name: String
        
        var initialsName: String {
            name.components(separatedBy: " ").reduce("") {
                ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }
        }
        
    }
    
    var statut: String {
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
    
    var initialsName: String {
        name.components(separatedBy: " ").reduce("") {
            ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }
    }
    
    var listTags: String {
        return tags.joined(separator: " #")
    }

    
    
    
    var formattedRegisteredDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: registered)
    }
}

