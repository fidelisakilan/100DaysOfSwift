//
//  ContentView.swift
//  UnitConverter
//
//  Created by Fidelis Akilan on 5/22/25.
//

import SwiftUI

struct ContentView: View {
    @State private var unitInput = "Celsius"
    @State private var unitOutput = "Farenheit"
    @State private var valueInput = 0.0
    
    private var valueOutput : Double {
        var tempInKelvin = 0.0
        switch unitInput {
        case "Celsius":
            tempInKelvin = valueInput + 273.15
        case "Farenheit":
            tempInKelvin = (valueInput - 32) * 5 / 9 + 273.15
        case "Kelvin":
            tempInKelvin = valueInput
        default:
            tempInKelvin = 0.0
        }
        
        switch unitOutput {
        case "Celsius":
            return tempInKelvin - 273.15
        case "Farenheit":
            return (tempInKelvin - 273.15) * 9 / 5 + 32
        case "Kelvin":
            return tempInKelvin
        default:
            return 0
        }

    }
    let temperatureUnits = ["Celsius", "Farenheit", "Kelvin"]
    var body: some View {
        NavigationStack {
            Form {
                Section("Parameters") {
                    TextField("Enter Temp",value: $valueInput,format: .number)
                        .keyboardType(.numberPad)
                    Picker("Input Unit", selection: $unitInput) {
                        ForEach(temperatureUnits,id: \.self) {
                            Text($0)
                        }
                    }
                    Picker("Output Unit", selection: $unitOutput) {
                        ForEach(temperatureUnits,id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section("RESULT") {
                    Text(String(valueOutput))
                }
            }
            .navigationTitle("Unit Converter")
        }
    }
}

#Preview {
    ContentView()
}
