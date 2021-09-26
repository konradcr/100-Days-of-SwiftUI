//
//  ContentView.swift
//  FriendFace
//
//  Created by Konrad Cureau on 28/06/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {

    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: []
    ) var users: FetchedResults<User>
    
    var body: some View {
        NavigationView {
            List(users, id: \.self) { user in
                NavigationLink(destination: DetailUserView(user: user /*, friendsMember: self.users */)) {
                VStack(alignment: .leading) {
                    Label {
                        HStack {
                            Text(user.wrappedName)
                                .font(.body)
                                .foregroundColor(.primary)
                            Text(user.wrappedCompany.uppercased())
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
            }.onAppear(perform: loadUserData)
            .navigationBarTitle("FriendFace")
        }
        
    }
   
    func loadUserData() {
            guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
                print("Invalid URL")
                return
            }

            let request = URLRequest(url: url)

            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let userData = data else {
                    print("No data in response: \(error?.localizedDescription ?? "Unknown Error")")
                    return
                }

                let userDecoder = JSONDecoder()

                userDecoder.dateDecodingStrategy = .iso8601
                userDecoder.userInfo[CodingUserInfoKey.context!] = moc

                do {
                    let _ = try userDecoder.decode([User].self, from: userData)

                    if self.moc.hasChanges {
                        try? self.moc.save()
                    }
                } catch {
                    print("Decoding Failed: \(error.localizedDescription)")
                }

            }.resume()
        }
 
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
