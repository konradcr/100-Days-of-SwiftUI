//
//  ContentView.swift
//  UsersNetWork
//
//  Created by Konrad Cureau on 25/06/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()

    var body: some View {
        NavigationView {
            List(users, id: \.id) { user in
                NavigationLink(destination: DetailView(user: user /*, friendsMember: self.users */)) {
                        VStack(alignment: .leading) {
                            Label {
                                HStack {
                                    Text(user.name)
                                        .font(.body)
                                        .foregroundColor(.primary)
                                    Text(user.company.uppercased())
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                .padding()
                                
                            } icon: {
                            Circle()
                                .fill(user.colorUser)
                                .opacity(0.8)
                                .frame(width: 44, height: 44, alignment: .center)
                                .overlay(
                                    Text(user.initialsName)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .shadow(radius: 10)
                                        
                                )
                            }
                        }
                }
            }.onAppear(perform: loadData)
            .navigationBarTitle("FriendFace")
        }
    }
    
    func loadData() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let users = try decoder.decode([User].self, from: data)
                    DispatchQueue.main.async {
                        self.users = users
                        
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
