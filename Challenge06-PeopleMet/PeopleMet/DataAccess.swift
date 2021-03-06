//
//  DataAccess.swift
//  PeopleMet
//
//  Created by Konrad Cureau on 07/07/2021.
//

import Foundation

private func fetchDataFromFile(_ filePath: URL) -> Data? {
    if FileManager.default.fileExists(atPath: filePath.path) {
        guard let data = try? Data(contentsOf: filePath) else {
            fatalError(filePath.path + " doesn't exist.")
        }
        return data
    }
    return nil
}

private func decodeData(data: Data) -> [Contact] {
    let decoder = JSONDecoder()
    do {
        let decodedData = try decoder.decode([Contact].self, from: data)
        return decodedData
    } catch {
        print("Error while decoding: " + error.localizedDescription)
        return []
    }
}

private func encodeData(toBeEncoded: [Contact]) -> Data? {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    do {
        let encodedData = try encoder.encode(toBeEncoded)
        return encodedData
    } catch {
        print("Error while encoding: " + error.localizedDescription)
        return nil
    }
}

private func writeDataToFile(toWrite dataToBeWritten: Data, inFile file: URL) {
    do {
        try dataToBeWritten.write(to: file, options: [.atomic, .completeFileProtection])
    } catch {
        print("Error when writing to file: " + error.localizedDescription)
    }
}

/**** Public Methods ****/

func appendContactToFile(newContact: Contact, filePath: URL) {
    if let oldData = fetchDataFromFile(filePath) {
        var contacts = decodeData(data: oldData)
        contacts.append(newContact)
        if let newEncodedData = encodeData(toBeEncoded: contacts) {
            writeDataToFile(toWrite: newEncodedData, inFile: filePath)
        }
    } else {
        if let newEncodedData =  encodeData(toBeEncoded: [newContact]) {
            writeDataToFile(toWrite: newEncodedData, inFile: filePath)
        }
    }
}

func getDataFromJSONFile(path: URL) -> [Contact] {
    if let data = fetchDataFromFile(path) {
        printJSONFile(data: data)
        let decoded = decodeData(data: data)

        return decoded
    }
    return []
}

func printJSONFile(data: Data) {
   // data.map{print(String(data: $0.name, encoding: .utf8) ?? "Can't Print JSON file");}
}
