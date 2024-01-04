//
//  ContentView.swift
//  Easy Convert
//
//  Created by Andrea Bottino on 03/01/2024.
//

import SwiftUI

struct ContentView: View {
    
    private let units = [
        ["-", "km", "m", "cm", "mm", "mi", "yd", "ft", "in"],
        ["-", "kg", "g", "mg", "lb", "oz"],
        ["-", "°C", "K", "°F"]
    ]
    
    @State private var valueToConvert = 0.0
    @State private var unitTag = 0
    @State private var startUnit = "-"
    @State private var targetUnit = "-"
    @State private var convertedValue = 0.0
    @FocusState private var valueIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Types", selection: $unitTag) {
                        Text("Length").tag(0)
                        Text("Weight").tag(1)
                        Text("Temperature").tag(2)
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: unitTag) {
                        startUnit = "-"
                        targetUnit = "-"
                    }
                }
                
                HStack {
                    Picker("From", selection: $startUnit) {
                        ForEach(units[unitTag], id: \.self) {
                            Text($0).tag($0)
                        }
                    }
                    Picker("To", selection: $targetUnit) {
                        ForEach(units[unitTag], id: \.self) {
                            Text($0).tag($0)
                        }
                    }
                }
                
                Section {
                    HStack {
                        TextField("Amount to convert", value: $valueToConvert, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($valueIsFocused)
                        Text(UnitConversions.convertSymbols(symbol: startUnit))
                    }
                } header: {
                    Text("Enter value to convert")
                }
                
                HStack {
                    Spacer()
                    Button("Convert") {
                        if unitTag == 2 {
                            convertedValue = UnitConversions.convertTemperature(value: valueToConvert, startUnit: startUnit, targetUnit: targetUnit)
                        } else {
                            convertedValue = UnitConversions.convert(value: valueToConvert, startUnit: startUnit, targetUnit: targetUnit)
                        }
                    }
                    Spacer()
                }
                
                Section {
                    HStack {
                        Text(String(format: "%.3f", convertedValue))
                        Spacer()
                        Text(UnitConversions.convertSymbols(symbol: targetUnit))
                    }
                } header: {
                    Text("Converted value:")
                }
            }
            .navigationTitle("Easy Convert")
            .toolbar(content: {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        valueIsFocused = false
                    }
                }
            })
        }
    }
}


#Preview {
    ContentView()
}
