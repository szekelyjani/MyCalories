//
//  ViewController.swift
//  MyCalories
//
//  Created by Szekely Janos on 2022. 08. 18..
//

import CoreData
import UIKit

class ViewController: UIViewController {
    var tCalories: String!
    var foods = [Food]()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var totalCaloriesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculateCalories()
        
        imageView.image = UIImage(named: "calories-calculator")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        calculateCalories()
    }
    
    func calculateCalories() {
        var total: Float = 0
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        let fetchRequest: NSFetchRequest<Food> = Food.fetchRequest()
        
        do {
            foods = try delegate.persistentContainer.viewContext.fetch(fetchRequest)
        }
        catch {
            print(error.localizedDescription)
        }
        
        if foods.isEmpty {
            totalCaloriesLabel.text = "0 calorie"
        } else {
            for food in foods {
                total += food.calories
            }
            totalCaloriesLabel.text = "\(total) calories"
        }
    }
}

