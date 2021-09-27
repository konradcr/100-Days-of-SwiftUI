//
//  ContentView.swift
//  Converter
//
//  Created by Konrad Cureau on 08/04/2021.
//

import SwiftUI

struct ContentView: View {

    @State private var inputValue = ""
    @State private var inUnit = 0
    @State private var outUnit = 2

    let units = ["Celsius", "Fahrenheit", "Kelvin"]

    var convertedValue: Double {
        let valueToConvert = Double(inputValue) ?? 0
        let inSelection = units[inUnit]
        let outSelection = units[outUnit]

        var inToCelsius: Double {
            switch inSelection {
            case "Celsius":
                return valueToConvert
            case "Fahrenheit":
                return 5/9 * (valueToConvert - 32)
            case "Kelvin":
                return valueToConvert - 273
            default:
                return 0
            }
        }

        var celsiusToOut: Double {
            switch outSelection {
            case "Celsius":
                return inToCelsius
            case "Fahrenheit":
                return 9/5 * inToCelsius + 32
            case "Kelvin":
                return inToCelsius + 273
            default:
                return 0
            }
        }

        return celsiusToOut
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Value", text: $inputValue)
                            .keyboardType(.decimalPad)
                }

                Section(header: Text("Units")) {
                    Picker("Input", selection: $inUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    Picker("Output", selection: $outUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                }

                if inputValue.isEmpty == false {
                    Section(header: Text("Converted Value")) {
                        Text("\(convertedValue, specifier: "%.2f")")
                    }
                }
            }
            .navigationBarTitle("Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
