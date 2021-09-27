//
//  Model.swift
//  UsersNetWork
//
//  Created by Konrad Cureau on 27/06/2021.
//

import Foundation
import SwiftUI

class Model: ObservableObject {

    @Published var allUsers = [User]()

    init() {
        allUsers = Bundle.main.decode("friendface.json")
    }

    func loadData() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let users = try decoder.decode([User].self, from: data)
                    DispatchQueue.main.async {
                        self.allUsers = users
                    }
                } catch {
                    print(error)
                }
            } else {
                // if we're still here it means there was a problem
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
}
