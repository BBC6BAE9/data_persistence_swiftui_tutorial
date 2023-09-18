//
//  DataController.swift
//  iCalories
//
//  Created by henry on 2023/9/18.
//

import SwiftUI
import CoreData

class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "FoodModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    // 保存
    func save(context:NSManagedObjectContext)  {
        do{
            try context.save()
            print("Data saved")
        } catch{
            print("we could not save data...")
        }
    }
    
    // 添加食物
    func addFood(name:String, calories:Double, context:NSManagedObjectContext) {
        let food = Food(context: context)
        food.id = UUID()
        food.date = Date()
        food.name = name
        food.calories = calories
        
        save(context: context)
    }
    
    // 编辑食物
    func editFood(food:Food, name:String, calories:Double, context:NSManagedObjectContext) {
        food.date = Date()
        food.name = name
        food.calories = calories
        
        save(context: context)
    }
    
}
