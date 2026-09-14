//
//  ContentView.swift
//  UnitConversions
//
//  Created by Vladislav on 09.04.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = 0.0
    @State private var inputType = UnitTemperature.celsius
    @State private var outputType = UnitTemperature.kelvin
    
    private let units: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
    
    private var baseMeasurement: Measurement<UnitTemperature> {
        let inputMeasurement = Measurement(value: inputValue, unit: inputType)
        return inputMeasurement.converted(to: .kelvin)
    }
    
    private var outputMeasurement: Measurement<UnitTemperature> {
        baseMeasurement.converted(to: outputType)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section ("Input type") {
                    Picker("Input type", selection: $inputType) {
                        ForEach(units, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Input value") {
                    TextField("Value", value: $inputValue, format: .number)
                }
                
                Section ("Output  type") {
                    Picker("Output type", selection: $outputType) {
                        ForEach(units, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Output value") {
                    Text("\(outputMeasurement.formatted(.measurement(width: .abbreviated, usage: .asProvided)))")
                }
            }
            .navigationTitle("Unit Conversions")
        }
    }
}

#Preview {
    ContentView()
}

