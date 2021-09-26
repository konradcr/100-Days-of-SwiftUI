//
//  DetailUserView.swift
//  FriendFace
//
//  Created by Konrad Cureau on 29/06/2021.
//

import SwiftUI
import CoreData

struct DetailUserView: View {
    @Environment(\.managedObjectContext) var moc
    let user: User
    
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
                    Text(self.user.wrappedName)
                        .font(.title)
                        .foregroundColor(.primary)
                    Text("\(self.user.age)")
                        .font(.title)
                        .foregroundColor(.secondary)
                }
                Text(self.user.wrappedCompany.uppercased())
                    .font(.headline)
            }
            Spacer()

            }
            
            
            Form {
                Section(header: Text("Contact")) {
                    Label(self.user.wrappedEmail, systemImage: "at.circle.fill")
                    Label(self.user.wrappedAddress, systemImage: "house.circle.fill")
                }
                
                
                Section(header: Text("About")){
                    Text(self.user.wrappedAbout)
                        .padding()
//                    Text("#\(self.user.listTags)")
//                        .padding()

//                    List(self.user.tagsArray) { tag in
//                        Text(tag.wrappedWord)
//                    }
                    
                }
                
//                Section(header: Text("Friends")) {
//                    List(self.user.friends) { person in
//                        self.getFriendDetails(friend: person, of: users).map{
//                            NavigationLink(destination: DetailView(user: $0)) {
//                                HStack {
//                               Circle()
//                                .fill(user.colorUser)
//                                   .opacity(0.8)
//                                   .frame(width: 44, height: 44, alignment: .center)
//                                   .overlay(
//                                    Text(person.initialsName)
//                                           .fontWeight(.bold)
//                                           .foregroundColor(.white)
//                                           .shadow(radius: 10)
//
//                                   )
//                               Text(person.name)
//                                   .font(.body)
//                                   .foregroundColor(.primary)
//                           }
//                            }.isDetailLink(false)
//                        }
//
//                    }
//
//                }
//
                
            }
            Text("Registered since: \(self.user.formattedRegisteredDate)")
                .font(.subheadline)
        }
    }
}


struct DetailUserView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        let newUser = User(context: moc)
        newUser.id = UUID()
        newUser.name = "Konrad"
        newUser.isActive = true
        newUser.age = Int16(24)
        newUser.company = "Apple"
        newUser.address = "France"
        newUser.email = "@icloud.com"
        newUser.about = "I would like to become an iOS Dev"
        newUser.registered = Date()
        let newTag = Tag(context: moc)
        newTag.word = "tech"
        let newFriend = Friend(context: moc)
        newFriend.id = UUID()
        newFriend.name = "Lucile"

        return NavigationView {
            DetailUserView(user: newUser)
        }
    }
}
