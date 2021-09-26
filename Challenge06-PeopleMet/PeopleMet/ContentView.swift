//
//  ContentView.swift
//  PeopleMet
//
//  Created by Konrad Cureau on 06/07/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var contacts = [Contact]()
    @State private var showingAddContact = false


    
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    VStack {
                        List {
                            ForEach(contacts.sorted()) { contact in
                                HStack {
                                    Image(uiImage: UIImage(data: contact.photo) ?? UIImage(systemName: "swift")!)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                    Text(contact.name)
                                }
                            }.onDelete(perform: removeItems)
                        }
                    }
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                self.showingAddContact = true
                                            }) {
                                                Image(systemName: "plus")
                                            }
                                            .padding()
                                            .background(Color.black.opacity(0.75))
                                            .foregroundColor(.white)
                                            .font(.title)
                                            .clipShape(Circle())
                                            .padding(.trailing)
                        }.padding(.bottom)
                    }
                    
                }
            }
            .navigationTitle("PeopleMet")
            .sheet(isPresented: $showingAddContact, onDismiss: loadJsonData) {
                AddContactView()
            }
            .onAppear(perform: loadJsonData)
            
        }
    }
    
    func loadJsonData() {
        contacts = getDataFromJSONFile(path: getDocumentsDirectory())
       // print(contacts)
    }
    
    func getDocumentsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fullPath = path[0].appendingPathComponent("contacts.json")
        return fullPath
    }
    
    func removeItems(at offsets: IndexSet) {
        var listContacts = contacts.sorted()
        listContacts.remove(atOffsets: offsets)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
