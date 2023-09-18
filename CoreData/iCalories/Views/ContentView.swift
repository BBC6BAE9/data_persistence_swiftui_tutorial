//
//  ContentView.swift
//  iCalories
//
//  Created by henry on 2023/9/18.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext

    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var foods:FetchedResults<Food>
    
    @State private var showAddView = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                Text("\(Int(totalCalories())) kcal Today")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                List {
                    ForEach(foods){ food in
                        NavigationLink(destination: EditFoodView(food: food)) {
                            HStack{
                                VStack(alignment: .leading) {
                                    Text(food.name!)
                                        .bold()
                                    Text("\(Int(food.calories)) ") + Text("calories").foregroundColor(.red)
                                }
                                Spacer()
                                Text(calTimeSince(date: food.date!))
                            }
                        }
                    }
                    .onDelete(perform: { indexSet in
                        deleteFood(offsetIndex: indexSet)
                    })
                }
                .listStyle(.plain)
            }
            .navigationTitle("iCalories")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        showAddView.toggle()
                    } label: {
                        Label("Add food", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showAddView, content: {
                AddFoodView()
            })
        }
        .navigationViewStyle(.stack)
    }
    
    /// 删除食物
    private func deleteFood(offsetIndex: IndexSet){
        withAnimation {
            offsetIndex.map{foods[$0]}.forEach(managedObjectContext.delete)
            DataController().save(context: managedObjectContext)
        }
    }
    
    private func totalCalories() -> Double {
        var caloriesToday:Double = 0
        for item in foods {
            if Calendar.current.isDateInToday(item.date!) {
                caloriesToday += item.calories
            }
        }
        return caloriesToday
    }
}

#Preview {
    ContentView()
}
