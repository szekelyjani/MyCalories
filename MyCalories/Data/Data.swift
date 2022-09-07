//
//  Data.swift
//  MyCalories
//
//  Created by Szekely Janos on 2022. 08. 24..
//

import CoreData
import Foundation
import UIKit

class Data {
    private let sortingKey = "id"
    private let delegate = UIApplication.shared.delegate as! AppDelegate
    private let fetchMeal: NSFetchRequest<Meal> = Meal.fetchRequest()
    private let fetchFood: NSFetchRequest<Food> = Food.fetchRequest()
    var meals = [Meal]()
    var foods: [Food]?
    var item: Item?
    
    private func createMeals() {
        let dinner = Meal(context: delegate.persistentContainer.viewContext)
        dinner.name = "Dinner"
        dinner.id = 2
        
        let lunch = Meal(context: delegate.persistentContainer.viewContext)
        lunch.name = "Lunch"
        lunch.id = 1
        
        let breakfast = Meal(context: delegate.persistentContainer.viewContext)
        breakfast.name = "Breakfast"
        breakfast.id = 0
        
        saveData()
    }
    
    func saveData() {
        delegate.saveContext()
    }
    
    func loadMeals() -> [Meal] {

        meals = fetchMeals()
        
        if meals.isEmpty {
            createMeals()
            meals = fetchMeals()
        }
        
        return meals
    }
    
    private func fetchMeals() -> [Meal] {
        fetchMeal.sortDescriptors = [NSSortDescriptor(key: sortingKey, ascending: true)]
        do {
            meals = try delegate.persistentContainer.viewContext.fetch(fetchMeal)
        } catch {
            print(error.localizedDescription)
        }
        
        return meals
    }
    
    func loadFoodsWith(predicate: Meal) -> [Food] {
        let predicate = NSPredicate(format: "meal == %@", predicate)
        fetchFood.predicate = predicate
        
        do {
            foods = try delegate.persistentContainer.viewContext.fetch(fetchFood)
            
        }
        catch {
            print(error.localizedDescription)

        }
        return foods!
    }
    
    func loadFoods() -> [Food] {
        do {
            foods = try delegate.persistentContainer.viewContext.fetch(fetchFood)
        } catch {
            print(error.localizedDescription)
        }
        return foods!
    }
    
    func addFood(item: Item, mealFor: String) {
        let meals = loadMeals()
        let food = Food(context: delegate.persistentContainer.viewContext)
        food.name = item.name.capitalized
        food.calories = item.calories
        food.saturatedFat = item.fat_saturated_g
        food.cholesterol = item.cholesterol_mg
        food.potassium = item.potassium_mg
        food.sodium = item.sodium_mg
        food.totalCarbohydrates = item.carbohydrates_total_g
        food.sugar = item.sugar_g
        food.protein = item.protein_g
        food.totalFat = item.fat_total_g
        food.meal = meals[getMealIndex(meals: meals, mealFor: mealFor)]

        saveData()
    }

    private func getMealIndex(meals: [Meal], mealFor: String) -> Int {
        for meal in meals {
            if meal.name == mealFor {
                return meals.firstIndex(of: meal)!
            }
        }
        return 0
    }
}
