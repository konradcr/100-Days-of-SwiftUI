//
//  ContentView.swift
//  WhoIMet
//
//  Created by Konrad Cureau on 08/07/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: Contact.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Contact.name, ascending: true)]
    ) var contacts: FetchedResults<Contact>

    @State private var showingAddContact = false

    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(contacts) { contact in
                        NavigationLink(destination: DetailContactView(contact: contact)) {
                            HStack {
                                Image(uiImage: UIImage(data: contact.wrappedPhoto)!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())

                                Text(contact.wrappedName)
                                    .font(.title3)
                            }
                        }
                    }
                    .onDelete(perform: deleteContact(at:))
                }
                .navigationBarTitle("Who I Met")
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
                }
                .padding(.bottom)
            }
        }
        .sheet(isPresented: $showingAddContact) {
            AddContactView().environment(\.managedObjectContext, self.moc)
        }
    }

    func deleteContact(at offsets: IndexSet) {
        for offset in offsets {
            let contact = contacts[offset]
            moc.delete(contact)
        }
        if self.moc.hasChanges {
            try? self.moc.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
