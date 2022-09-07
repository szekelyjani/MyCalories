//
//  ItemFetcher.swift
//  MyCalories
//
//  Created by Szekely Janos on 2022. 08. 19..
//

import Foundation

class ItemFetcher {
    private let keyString = "RlwzliVWjyMnLI2v9tW+jw==oEKB73xfmy509VR5"
    private let baseURL = "https://api.calorieninjas.com/v1/nutrition?query="
    
    var action: ((Items) -> Void)?
    
    func fetch(itemName: String, action: ((Items) -> Void)?) {
        self.action = action
        
        let query = itemName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let url = URL(string: baseURL+query!) else { return }
        var request = URLRequest(url: url)
        request.setValue(keyString, forHTTPHeaderField: "X-Api-Key")
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            let decoder = JSONDecoder()
            
            guard let data = data else { return }
            do {
                let result = try decoder.decode(Items.self, from: data)
                self.action?(result)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
