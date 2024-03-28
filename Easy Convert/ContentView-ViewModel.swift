//
//  ContentView-ViewModel.swift
//  Easy Convert
//
//  Created by Andrea Bottino on 28/03/2024.
//

import Foundation

extension ContentView {
    
    @Observable
    final class ViewModel {
        
        let units = [
            ["-", "km", "m", "cm", "mm", "mi", "yd", "ft", "in"],
            ["-", "kg", "g", "mg", "lb", "oz"],
            ["-", "°C", "K", "°F"]
        ]
        
        var valueToConvert = 0.0
        var unitTag = 0
        var startUnit = "-"
        var targetUnit = "-"
        
        var convertedValue : Double {
            if unitTag == 2 {
                return convertTemperature(value: valueToConvert, startUnit: startUnit, targetUnit: targetUnit)
            } else {
                return convert(value: valueToConvert, startUnit: startUnit, targetUnit: targetUnit)
            }
        }
        
        let conversionFactors: [String: Double] = [
            
            //LENGHTS
            
            "km-km": 1,
            "km-m": 1_000,
            "km-cm": 100_000,
            "km-mm": 1_000_000,
            "km-mi": 0.6213689,
            "km-yd": 1093.6132983,
            "km-ft": 3280.839895,
            "km-in": 39370.07874,
            
            "m-m": 1,
            "m-km": 0.001,
            "m-cm": 100,
            "m-mm": 1_000,
            "m-mi": 0.0006213689,
            "m-yd": 1.0936132983,
            "m-ft": 3.280839895,
            "m-in": 39.37007874,
            
            "cm-cm": 1,
            "cm-km": 0.00001,
            "cm-m": 0.01,
            "cm-mm": 10,
            "cm-mi": 0.0000062137,
            "cm-yd": 0.010936133,
            "cm-ft": 0.032808399,
            "cm-in": 0.3937007874,
            
            "mm-mm": 1,
            "mm-km": 0.000001,
            "mm-m": 0.001,
            "mm-cm": 0.1,
            "mm-mi": 0.000062137,
            "mm-yd": 0.0010936133,
            "mm-ft": 0.0032808399,
            "mm-in": 0.0393700787,
            
            "mi-mi": 1,
            "mi-km": 1.60935,
            "mi-m": 1609.35,
            "mi-cm": 160935,
            "mi-mm": 1609350,
            "mi-yd": 1760.0065617,
            "mi-ft": 5280.019685,
            "mi-in": 63360.23622,
            
            "yd-yd": 1,
            "yd-km": 0.0009144,
            "yd-m": 0.9144,
            "yd-cm": 91.44,
            "yd-mm": 914.4,
            "yd-mi": 0.0005681797,
            "yd-ft": 3,
            "yd-in": 36,
            
            "ft-ft": 1,
            "ft-km": 0.0003048,
            "ft-m": 0.3048,
            "ft-cm": 30.48,
            "ft-mm": 304.8,
            "ft-mi": 0.0001893932,
            "ft-yd": 0.3333333333,
            "ft-in": 12,
            
            "in-in": 1,
            "in-km": 0.0000254,
            "in-m": 0.0254,
            "in-cm": 2.54,
            "in-mm": 25.4,
            "in-mi": 0.0000157828,
            "in-yd": 0.0277777778,
            "in-ft": 0.0833333333,
            
            //WEIGHTS
            
            "kg-kg": 1,
            "kg-g": 1_000,
            "kg-mg": 1_000_000,
            "kg-lb": 2.2046244202,
            "kg-oz": 35.273990723,
            
            "g-g": 1,
            "g-kg": 0.001,
            "g-mg": 1000,
            "g-lb": 0.0022046244,
            "g-oz": 0.0352739907,
            
            "mg-mg": 1,
            "mg-kg": 0.000001,
            "mg-g": 0.001,
            "mg-lb": 0.0000022046,
            "mg-oz": 0.000035274,
            
            "lb-lb": 1,
            "lb-kg": 0.453592,
            "lb-g": 453.592,
            "lb-mg": 453592,
            "lb-oz": 16,
            
            "oz-oz": 1,
            "oz-kg": 0.0283495,
            "oz-g": 28.3495,
            "oz-mg": 28349.5,
            "0z-lb": 0.0625,
            
        ]
        
        func convert(value: Double, startUnit: String, targetUnit: String) -> Double {
            if let factor = conversionFactors["\(startUnit)-\(targetUnit)"] {
                return value * factor
            }
            return value
        }
        
        func convertTemperature(value: Double, startUnit: String, targetUnit: String) -> Double {
            if startUnit == "°C" && targetUnit == "°C" {
                return value
            } else if startUnit == "°C" && targetUnit == "K" {
                return value + 273.15
            } else if startUnit == "°C" && targetUnit == "°F" {
                return (9 / 5) * value + 32
            }
            
            else if startUnit == "K" && targetUnit == "K" {
                return value
            } else if startUnit == "K" && targetUnit == "°C" {
                return value - 273.15
            } else if startUnit == "K" && targetUnit == "°F" {
                return 9 / 5 * (value - 273.15) + 32
            }
            
            else if startUnit == "°F" && targetUnit == "°F" {
                return value
            } else if startUnit == "°F" && targetUnit == "°C" {
                return 5 / 9 * (value - 32)
            } else if startUnit == "°F" && targetUnit == "K" {
                return (value + 459.67) / 1.8
            }
            return value
        }
        
        func convertSymbols(symbol: String) -> String {
            switch symbol {
            case "km": return "kilometers"
            case "m": return "meters"
            case "cm": return "centimeters"
            case "mm": return "millimeters"
            case "mi": return "miles"
            case "yd": return "yards"
            case "ft": return "foot"
            case "in": return "inches"
            case "kg": return "kilograms"
            case "g": return "grams"
            case "mg": return "milligrams"
            case "lb": return "pounds"
            case "oz": return "ounches"
            case "°C": return "Celsius"
            case "°K": return "Kelvin"
            case "°F": return "Fahrenheit"
            default: return "-"
            }
        }
    }
}
