//
//  ContentView.swift
//  WeSplit
//
//  Created by Ian Bailey on 20/8/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var billAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let currencyCode: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = billAmount / 100 * tipSelection
        return billAmount + tipValue
    }
    
    var totalperperson: Double {
        let peopleCount = Double (numberOfPeople + 2)
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $billAmount,
                              format: currencyCode)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) of people")
                        }
                    }
                    
                }
                
                Section {
                    Picker("", selection: $tipPercentage) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    //.pickerStyle(.wheel)
                }
                header: {
                    Text("Tip")
                }
                
                Section {
                    Text(grandTotal, format: currencyCode)
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                }
                header: {
                    Text("Total BILL")
                }
                
                Section {
                    Text(totalperperson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }
                header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
