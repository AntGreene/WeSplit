//
//  ContentView.swift
//  WeSplit
//
//  Created by user279044 on 9/7/25.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Sets Variables
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    @State private var isShowingTipPicker = false
    
    // MARK: - Computed Properties
    
    var totalCheckAmount: Double {
        let tipValue = checkAmount * Double(tipPercentage) / 100
        return checkAmount + tipValue
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        return totalCheckAmount / peopleCount
    }
    
    var body: some View {
        NavigationStack {
            Form {
                // MARK: - Amount & People Picker
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                // MARK: - Tip Picker Section
                Section("Tip percentage") {
                    NavigationLink {
                        TipPickerView(tipPercentage: $tipPercentage)
                    } label: {
                        HStack {
                            Text("Tip: \(tipPercentage)%")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                // MARK: - Total Amount (before splitting)
                Section("Total check amount") {
                    Text(totalCheckAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                // MARK: - Amount Per Person
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

// MARK: - TipPickerView: New screen to select tip from 0% to 100%

struct TipPickerView: View {
    @Binding var tipPercentage: Int
    
    var body: some View {
        List {
            ForEach(0..<101, id: \.self) { percent in
                HStack {
                    Text("\(percent)%")
                    Spacer()
                    if percent == tipPercentage {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .contentShape(Rectangle()) // Makes the whole row tappable
                .onTapGesture {
                    tipPercentage = percent
                }
            }
        }
        .navigationTitle("Select Tip")
    }
}

#Preview {
    ContentView()
}
