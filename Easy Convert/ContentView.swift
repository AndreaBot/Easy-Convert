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
    @FocusState private var valueIsFocused: Bool
    
    private var convertedValue : Double {
        if unitTag == 2 {
            return UnitConversions.convertTemperature(value: valueToConvert, startUnit: startUnit, targetUnit: targetUnit)
        } else {
            return UnitConversions.convert(value: valueToConvert, startUnit: startUnit, targetUnit: targetUnit)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Picker("Types", selection: $unitTag) {
                    Text("Length").tag(0)
                    Text("Weight").tag(1)
                    Text("Temperature").tag(2)
                }
                .padding()
                .pickerStyle(.segmented)
                .onChange(of: unitTag) {
                    startUnit = "-"
                    targetUnit = "-"
                    valueToConvert = 0
                }
            Form {
                HStack {
                    Button("", systemImage: "arrow.up.arrow.down") {
                        let first = startUnit
                        let second = targetUnit
                        startUnit = second
                        targetUnit = first
                    }
                    .frame(maxWidth: 40)
                    .buttonStyle(PlainButtonStyle())
                    
                    VStack {
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
        }
            .navigationTitle("Easy Convert")
            .scrollDisabled(true)
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
