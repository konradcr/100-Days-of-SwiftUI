//
//  AddContactView.swift
//  WhoIMet
//
//  Created by Konrad Cureau on 08/07/2021.
//

import SwiftUI
import CoreData
import MapKit

enum ActiveSheet: Identifiable {
    case camera, library
    var id: Int {
        hashValue
    }
}

struct AddContactView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    
    @State var activeSheet: ActiveSheet?
    @State var allowTrackLocation = false
    
    @State private var name = ""
    @State private var image: Image?
    @State private var inputImage: UIImage?
    
    let locationFetcher = LocationFetcher()
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var currentLocation: CLLocationCoordinate2D?
    
    var body: some View {
        VStack {
            HStack(alignment:.top) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                }
                
                Spacer()
                Text("Add a person")
                    .font(.headline)
                Spacer()
                
                Button(action: {
                    saveContact()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Done").bold()
                }.disabled(self.name == "" || self.image == nil)
            }.padding()
            
            if image != nil {
                image?
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 200, height: 200, alignment: .center)
            } else {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200, alignment: .center)
                    .foregroundColor(.gray)
            }
            
            HStack {
                Button(action: {
                    activeSheet = .camera
                }) {
                    VStack {
                        Image(systemName: "camera")
                            .padding()
                            .background(Color.blue.opacity(0.3))
                            .foregroundColor(.blue)
                            .font(.title)
                            .clipShape(Circle())
                    }
                }
                Button(action: {
                    activeSheet = .library
                }) {
                    VStack {
                        Image(systemName: "photo.on.rectangle")
                            .padding()
                            .background(Color.blue.opacity(0.3))
                            .foregroundColor(.blue)
                            .font(.title)
                            .clipShape(Circle())
                    }
                }
                Button(action: {
                    self.allowTrackLocation.toggle()
                    if allowTrackLocation {
                        if let locationUser = self.locationFetcher.lastKnownLocation {
                            print("Your location is \(locationUser)")
                            self.currentLocation = locationUser
                        } else {
                            print("Your location is unknown")
                        }
                    } else {
                        self.currentLocation = nil
                    }
                }) {
                    VStack {
                        Image(systemName: allowTrackLocation ? "location.fill" : "location")
                            .padding()
                            .background(allowTrackLocation ? Color.blue.opacity(0.3) : Color.gray.opacity(0.3))
                            .foregroundColor(allowTrackLocation ? .blue : .gray)
                            .font(.title)
                            .clipShape(Circle())
                    }
                }
            }
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .disableAutocorrection(true)
            
            MapView(centerCoordinate: $centerCoordinate, currentLocation: currentLocation)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .padding()
                .onAppear(perform: self.locationFetcher.start)
            
        }.sheet(item: $activeSheet, onDismiss: loadImage) { item in
            switch item {
            case .camera:
                ImagePicker(image: self.$inputImage, sourceType: .camera)
            case .library:
                ImagePicker(image: self.$inputImage, sourceType: .photoLibrary)
            }
        }
        
        
        
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    
    func saveContact() {
        let imageUnwrapp = inputImage ?? UIImage(systemName: "person.crop.circle")!
        let jpegPhoto = imageUnwrapp.jpegData(compressionQuality: 0.8)
        let newContact = Contact(context: self.moc)
        newContact.name = self.name
        newContact.id = UUID()
        newContact.photo = jpegPhoto!
        if allowTrackLocation {
            newContact.latitude = currentLocation!.latitude
            newContact.longitude = currentLocation!.longitude
        }
        if self.moc.hasChanges {
            try? self.moc.save()
        }
        
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}
