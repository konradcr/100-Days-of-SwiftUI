//
//  DetailContactView.swift
//  WhoIMet
//
//  Created by Konrad Cureau on 09/07/2021.
//

import SwiftUI
import CoreData
import MapKit

struct DetailContactView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc

    @State private var showingDeleteAlert = false
    let locationFetcher = LocationFetcher()
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var annotation: MKPointAnnotation?

    let contact: Contact

    var body: some View {

        VStack {
            TabView {
                Image(uiImage: UIImage(data: contact.wrappedPhoto)!)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .tabItem {
                        Label("Photo", systemImage: "photo")
                    }

                ZStack {
                    MapView(centerCoordinate: $centerCoordinate, withAnnotation: annotation)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        .padding()
                        .disabled(contact.latitude == 0 && contact.longitude == 0)
                    if contact.latitude == 0 && contact.longitude == 0 {
                        Text("No location")
                            .font(.caption)
                            .fontWeight(.black)
                            .padding(8)
                            .foregroundColor(.white)
                            .background(Color.black.opacity(0.75))
                            .clipShape(Capsule())
                    } else {
                        EmptyView()
                    }
                }
                .tabItem {
                    Label("Map", systemImage: "map")
                }
            }
        }
        .onAppear(perform: putAnnotation)
        .navigationTitle(Text(contact.wrappedName))
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete Contact"),
                  message: Text("Are you sure ?"),
                  primaryButton: .destructive(Text("Delete")) { self.deleteContact() },
                  secondaryButton: .cancel()
            )
        }
        .navigationBarItems(
            trailing: Button(action: { self.showingDeleteAlert = true }) {
            Image(systemName: "trash")
            }
        )
    }

    func deleteContact() {
        moc.delete(contact)
        presentationMode.wrappedValue.dismiss()
    }

    func putAnnotation() {
        let newLocation = MKPointAnnotation()
        newLocation.coordinate = CLLocationCoordinate2D(latitude: contact.latitude, longitude: contact.longitude)
        self.annotation = newLocation
    }
}

struct DetailContactView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        let contact = Contact(context: moc)
        let jpegPhoto = UIImage(systemName: "person.crop.circle")!.jpegData(compressionQuality: 0.8)!
        contact.name = "Konrad"
        contact.id = UUID()
        contact.photo = jpegPhoto
        contact.latitude = 35.5
        contact.longitude = -2.5
        return NavigationView {
            DetailContactView(contact: contact)
        }
    }
}
