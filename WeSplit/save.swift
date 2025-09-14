//
//  save.swift
//  WeSplit
//
//  Created by user279044 on 9/7/25.
//

import SwiftUI

struct savef: View {
    
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry"
    
    @State private var tapCount = 0
    
    @State private var name = ""
    
    var body: some View {
       NavigationStack{
            Form{
                Section{
                    Picker("Select your student", selection: $selectedStudent){
                        ForEach(students, id: \.self){
                            Text($0)
                        }
                    }
                    
                    TextField("Enter your name", text: $name)
                    Text("Your name is \(name)")
                    Button("Tap Count: \(tapCount)"){
                        self.tapCount += 1
                    }
                }
            }
            .navigationTitle("SwiftUI")
        }
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

