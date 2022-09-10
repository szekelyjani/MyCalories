//
//  DiaryTableViewController.swift
//  MyCalories
//
//  Created by Szekely Janos on 2022. 08. 19..
//

import CoreData
import UIKit

class DiaryTableViewController: UITableViewController {
    private let delegate = UIApplication.shared.delegate as! AppDelegate
    private let data = Data()
    private let reuseIdentifier = "ItemCell"
    
    private var meals = [Meal]()
    private var foods = [Food]()

    private var allFoodsPerMeal = [AllFoodsPerMeal]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return allFoodsPerMeal.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFoodsPerMeal[section].foodsPerMeal.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ItemCell
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 1
        let current = allFoodsPerMeal[indexPath.section].foodsPerMeal[indexPath.row]
        cell.nameLabel.text = current.name
        cell.calorieLabel.text = "\(current.calories)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor = UIColor.orange
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: view.frame.width - 10, height: 40))
        label.text = allFoodsPerMeal[section].meal.name
        view.addSubview(label)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
          return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            foods = data.loadFoodsWith(predicate: allFoodsPerMeal[indexPath.section].meal)
            guard let index = foods.firstIndex(of: allFoodsPerMeal[indexPath.section].foodsPerMeal[indexPath.row]) else { return }
            delegate.persistentContainer.viewContext.delete(foods[index])
            data.saveData()
            allFoodsPerMeal[indexPath.section].foodsPerMeal.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AddFood") as? AddFoodView {
            let food = allFoodsPerMeal[indexPath.section].foodsPerMeal[indexPath.row]
            vc.food = food
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func configureTableView() {
        let nib = UINib(nibName: "ItemCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ItemCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadData() {
        allFoodsPerMeal.removeAll()
        meals = data.loadMeals()
        
        for meal in meals {
            foods = data.loadFoodsWith(predicate: meal)
            allFoodsPerMeal.append(AllFoodsPerMeal(meal: meal, foodsPerMeal: foods))
        }
    }
}
