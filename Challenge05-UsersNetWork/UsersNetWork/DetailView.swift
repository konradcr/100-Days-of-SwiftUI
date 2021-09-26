//
//  DetailView.swift
//  UsersNetWork
//
//  Created by Konrad Cureau on 26/06/2021.
//

import SwiftUI

struct DetailView: View {
    @State private var users = [User]()
    let user: User
    
//
//    struct FriendsMember {
//        let name: String
//        let friend: User
//    }
//
//    let friendsMember: [FriendsMember]
//
//    init(user: User, friendsMember: [User]) {
//        self.user = user
//
//        var matches = [FriendsMember]()
//
//        for member in user.friends {
//            if let match = friendsMember.first(where: {$0.id == member.id}) {
//                matches.append(FriendsMember(name: member.name, friend: match))
//            } else {
//                fatalError("Missing \(member)")
//            }
//        }
//        self.friendsMember = matches
//
//    }
    
//    let crew: [User.Friend]
//
//    init(user: User, friends: [User]) {
//        self.user = user
//
//        var matches = [User.Friend]()
//
//        for member in user.friends {
//            if let match = crew.first(where: { $0.id == member.id}) {
//                matches.append(User.Friend(id: match, name: member.name))
//            } else {
//                fatalError("Missing \(member)")
//            }
//        }
//        self.crew = matches
//    }
    
    var body: some View {
        VStack {
        HStack {
            Spacer()

            VStack (alignment: .leading) {
                Circle()
                    .fill(self.user.colorUser)
                    .opacity(0.8)
                    .frame(width: 100, height: 100, alignment: .center)
                    .overlay(
                        Text(user.initialsName)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .shadow(radius: 10)
                            .font(.largeTitle)
                    )
                
                HStack {
                    Circle()
                        .fill(self.user.statutColor)
                        .frame(width: 10, height: 10)
                    Text(self.user.statut)
                        .font(.subheadline)
                    
                    }.padding(.horizontal)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Capsule())
                    
                    
                    
                
            }
            Spacer()
            
            VStack (alignment: .leading) {
                HStack {
                    Text(self.user.name)
                        .font(.title)
                        .foregroundColor(.primary)
                    Text("\(self.user.age)")
                        .font(.title)
                        .foregroundColor(.secondary)
                }
                Text(self.user.company.uppercased())
                    .font(.headline)
            }
            Spacer()

            }
            
            
            Form {
                Section(header: Text("Contact")) {
                    Label(self.user.email, systemImage: "at.circle.fill")
                    Label(self.user.address, systemImage: "house.circle.fill")
                }
                
                
                Section(header: Text("About")){
                    Text(self.user.about)
                        .padding()
                    Text("#\(self.user.listTags)")
                        .padding()
                }
                
                Section(header: Text("Friends")) {
                    List(self.user.friends) { person in
                        self.getFriendDetails(friend: person, of: users).map{
                            NavigationLink(destination: DetailView(user: $0)) {
                                HStack {
                               Circle()
                                .fill(user.colorUser)
                                   .opacity(0.8)
                                   .frame(width: 44, height: 44, alignment: .center)
                                   .overlay(
                                    Text(person.initialsName)
                                           .fontWeight(.bold)
                                           .foregroundColor(.white)
                                           .shadow(radius: 10)

                                   )
                               Text(person.name)
                                   .font(.body)
                                   .foregroundColor(.primary)
                           }
                            }.isDetailLink(false)
                        }
//                        Group {
//                            NavigationLink(destination: DetailView(user: self.getFriendDetails(friend: person, of: users))  ) {
//                                HStack {
//                                    Circle()
//                                        .fill(Color.gray)
//                                        .opacity(0.8)
//                                        .frame(width: 44, height: 44, alignment: .center)
//                                        .overlay(
//                                            Text(person.initialsName)
//                                                .fontWeight(.bold)
//                                                .foregroundColor(.white)
//                                                .shadow(radius: 10)
//
//                                        )
//                                    Text(person.name)
//                                        .font(.body)
//                                        .foregroundColor(.primary)
//                                }
//                            }
//                        }
                    }.onAppear(perform: loadData)
                    
                }
                
                
            }
            Text("Registered since: \(self.user.formattedRegisteredDate)")
                .font(.subheadline)
        }
        
    }
    
    
    func getFriendDetails(friend: User.Friend, of list: [User]) -> User? {
        if let user = list.first(where: {($0.id == friend.id) && ($0.name == friend.name)}) {
            return user
        }
        return nil
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


