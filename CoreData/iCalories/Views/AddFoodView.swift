//
//  AddFoodView.swift
//  iCalories
//
//  Created by henry on 2023/9/18.
//

import SwiftUI

struct AddFoodView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Environment(\.dismiss) var dismiss
    
    
    @State private var name = ""
    @State private var calories:Double = 0
    
    var body: some View {
        Form(content: {
            Section{
                TextField("Food name", text: $name)
                
                VStack{
                    Text("calories:\(Int(calories))")
                    Slider(value: $calories, in: 0...1000, step: 10)
                }
                .padding()
                
                HStack{
                    Spacer()
                    Button("submit") {
                        DataController().addFood(name: name, calories: calories, context: managedObjectContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        })
    }
}

#Preview {
    AddFoodView()
}
