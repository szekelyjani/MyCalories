//
//  AddFoodView.swift
//  MyCalories
//
//  Created by Szekely Janos on 2022. 08. 20..
//

import CoreData
import UIKit

class AddFoodView: UIViewController {
    let data = Data()
    private let delegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var mealPicker: UIPickerView!
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var calorieAmountLabel: UILabel!
    @IBOutlet weak var saturatedFatLabel: UILabel!
    @IBOutlet weak var saturatedFatAmountLabel: UILabel!
    @IBOutlet weak var cholesterolLabel: UILabel!
    @IBOutlet weak var cholesterolAmountLabel: UILabel!
    @IBOutlet weak var potassiumLabel: UILabel!
    @IBOutlet weak var potassiumAmountLabel: UILabel!
    @IBOutlet weak var fiberLabel: UILabel!
    @IBOutlet weak var fiberAmountLabel: UILabel!
    @IBOutlet weak var sodiumLabel: UILabel!
    @IBOutlet weak var sodiumAmountLabel: UILabel!
    @IBOutlet weak var carbohydratesLabel: UILabel!
    @IBOutlet weak var carbohydratesAmountLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var sugarAmountLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var proteinAmountLabel: UILabel!
    @IBOutlet weak var totalFatLabel: UILabel!
    @IBOutlet weak var totalFatLAmountabel: UILabel!
    @IBOutlet weak var amountSlider: UISlider!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    var foodName: String?
    var food: Food?
    var item: Item?
    private var mealFor = "Breakfast"
    private let meals = ["Breakfast", "Lunch", "Dinner"]
    private var amount: Float = 100
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mealPicker.dataSource = self
        mealPicker.delegate = self
        if let food = food {
            print(food)
            let item = convertFoodToItem(food: food)
            setAmountLabels(item: item)
            amountSlider.isHidden = true
            addButton.isHidden = true
            amountLabel.text = String(format: "%.2f", item.serving_size_g) + " gram"
        } else {
            amountLabel.text = String(format: "%.2f", amountSlider.value) + " gram"
        }
        
        title = foodName
        
        setLabels()
        
        if let item = item {
            setAmountLabels(item: item)
        }
    }
    
    @IBAction func addButtonTouchUpInside(_ sender: Any) {
        if let item = item {
            data.addFood(item: calculateNutrion(item: item), mealFor: mealFor)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func amountSliderChange(_ sender: Any) {
        amountLabel.text = String(format: "%.2f", amountSlider.value) + " gram"
        amount = amountSlider.value
        if let item = item {
            setAmountLabels(item: calculateNutrion(item: item))
        }
    }
    
    private func setLabels() {
        calorieLabel.text = "Calories:"
        saturatedFatLabel.text = "Saturated fat:"
        cholesterolLabel.text = "Cholesterol:"
        potassiumLabel.text = "Potassium:"
        fiberLabel.text = "Fiber"
        sodiumLabel.text = "Sodium:"
        carbohydratesLabel.text = "Carbohydrates:"
        sugarLabel.text = "Sugar:"
        proteinLabel.text = "Protein:"
        totalFatLabel.text = "Total fat:"
    }
    
    private func setAmountLabels(item: Item) {
        calorieAmountLabel.text = "\(item.calories) cal"
        saturatedFatAmountLabel.text = "\(item.fat_saturated_g) g"
        cholesterolAmountLabel.text = "\(item.fat_saturated_g) g"
        fiberAmountLabel.text = "\(item.fiber_g) g"
        potassiumAmountLabel.text = "\(item.potassium_mg) mg"
        sodiumAmountLabel.text = "\(item.sodium_mg) mg"
        carbohydratesAmountLabel.text = "\(item.carbohydrates_total_g) g"
        sugarAmountLabel.text = "\(item.sugar_g) g"
        proteinAmountLabel.text = "\(item.protein_g) g"
        totalFatLAmountabel.text = "\(item.fat_total_g) g"
    }
    
    private func calculateNutrion(item: Item) -> Item {
        var item = item
        item.serving_size_g = amount
        item.calories = item.calories * amount / 100
        item.fat_saturated_g = item.fat_saturated_g * amount / 100
        item.fat_total_g = item.fat_total_g * amount / 100
        item.cholesterol_mg = item.cholesterol_mg * amount / 100
        item.potassium_mg = item.potassium_mg * amount / 100
        item.sodium_mg = item.sodium_mg * amount / 100
        item.carbohydrates_total_g = item.carbohydrates_total_g * amount / 100
        item.sugar_g = item.sugar_g * amount / 100
        item.protein_g = item.protein_g * amount / 100
        item.fiber_g = item.fiber_g * amount / 100
        return item
    }
    
    private func convertFoodToItem(food: Food) -> Item {
        let item = Item(sugar_g: food.sugar, fiber_g: food.fiber, serving_size_g: food.amount, sodium_mg: food.sodium, name: food.name!, potassium_mg: food.potassium, fat_saturated_g: food.saturatedFat, fat_total_g: food.totalFat, calories: food.calories, cholesterol_mg: food.cholesterol, protein_g: food.protein, carbohydrates_total_g: food.totalCarbohydrates)
        return item
    }
    
}

extension AddFoodView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return meals.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return meals[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        mealFor = meals[row]
    }
}

