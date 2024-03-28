//
//  ContentView.swift
//  Easy Convert
//
//  Created by Andrea Bottino on 03/01/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = ViewModel()
    @FocusState private var valueIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0, green: 0.3, blue: 0.8).opacity(0.6)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    Picker("Types", selection: $viewModel.unitTag) {
                        Text("Length").tag(0)
                        Text("Weight").tag(1)
                        Text("Temperature").tag(2)
                    }
                    .padding()
                    .pickerStyle(.segmented)
                    .onChange(of: viewModel.unitTag) {
                        viewModel.startUnit = "-"
                        viewModel.targetUnit = "-"
                        viewModel.valueToConvert = 0
                    }
                    Form {
                        HStack {
                            Button {
                                let first = viewModel.startUnit
                                let second = viewModel.targetUnit
                                viewModel.startUnit = second
                                viewModel.targetUnit = first
                            } label: {
                                Image(systemName: "arrow.up.arrow.down")
                            }
                            .frame(maxWidth: 40)
                            .buttonStyle(PlainButtonStyle())
                            
                            VStack {
                                Picker("From", selection: $viewModel.startUnit) {
                                    ForEach(viewModel.units[viewModel.unitTag], id: \.self) {
                                        Text($0).tag($0)
                                    }
                                }
                                Picker("To", selection: $viewModel.targetUnit) {
                                    ForEach(viewModel.units[viewModel.unitTag], id: \.self) {
                                        Text($0).tag($0)
                                    }
                                }
                            }
                        }
                        
                        Section {
                            HStack {
                                TextField("Amount to convert", value: $viewModel.valueToConvert, format: .number)
                                    .keyboardType(.decimalPad)
                                    .focused($valueIsFocused)
                                Text(viewModel.convertSymbols(symbol: viewModel.startUnit))
                            }
                        } header: {
                            Text("Enter value to convert")
                        }
                        
                        Section {
                            HStack {
                                Text(String(format: "%.3f", viewModel.convertedValue))
                                Spacer()
                                Text(viewModel.convertSymbols(symbol: viewModel.targetUnit))
                            }
                        } header: {
                            Text("Converted value:")
                        }
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
