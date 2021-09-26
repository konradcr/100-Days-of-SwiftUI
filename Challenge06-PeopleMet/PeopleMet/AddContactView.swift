//
//  AddContactView.swift
//  PeopleMet
//
//  Created by Konrad Cureau on 06/07/2021.
//

import SwiftUI

enum ActiveSheet: Identifiable {
    case camera, library
    
    var id: Int {
        hashValue
    }
}

struct AddContactView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var activeSheet: ActiveSheet?
    
    @State private var name = ""
    @State private var image: Image?
    @State private var inputImage: UIImage?


    var iconImage : Image {
        guard let image = image else { return Image(systemName: "person.crop.circle")}
        return image
    }
    
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
                    saveData()
                }) {
                    Text("Done").bold()
                }
            }.padding()
            iconImage
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200, alignment: .center)
                .foregroundColor(.gray)
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
            }
            
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .disableAutocorrection(true)
            Spacer()
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
    
    func saveData(){
        // Save contact in json file
        let path = getDocumentsDirectory().appendingPathComponent("contacts.json")

        let imageUnwrapp = inputImage ?? UIImage(systemName: "person.crop.circle")!
        
        if let jpegPhoto = imageUnwrapp.jpegData(compressionQuality: 0.8) {
            let newContact = Contact(photo: jpegPhoto, name: self.name)
            appendContactToFile(newContact: newContact, filePath: path)
        } else {
            print("Failed to compress image")
        }

        // dismiss view
        presentationMode.wrappedValue.dismiss()
    }
    
    
    
    func getDocumentsDirectory() -> URL {
           let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
           return path[0]
    }

}




struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}

