//
//  AddFoodView.swift
//  MyCalories
//
//  Created by Szekely Janos on 2022. 08. 20..
//

import UIKit

class SearchFoodView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    private let identifier = "seachResultCell"
    private let reuseIdentifier = "AddFood"
    let itemFetcher = ItemFetcher()
    var searchResult: Items?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
        
        searchTextField.placeholder = "Search for food"
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.borderColor = UIColor.white.cgColor
        
        title = "Search"
        
    }
    
    @IBAction func searchButtonTouchUpinside(_ sender: Any) {
        guard let seatchText = searchTextField.text else { return }
        itemFetcher.fetch(itemName: seatchText, action: { result in
            DispatchQueue.main.async {
                self.searchResult = result
                self.table.reloadData()
            }
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let result = self.searchResult {
            return result.items.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        if let result = searchResult?.items[indexPath.row] {
            content.text = result.name.capitalized
            content.secondaryText = "\(result.calories)"
        }
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: reuseIdentifier) as? AddFoodView {
            vc.foodName = searchResult?.items[indexPath.row].name.capitalized
            vc.item = searchResult?.items[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
