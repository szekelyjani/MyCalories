//
//  Items.swift
//  MyCalories
//
//  Created by Szekely Janos on 2022. 08. 19..
//

import Foundation

struct Items: Codable {
    var items: [Item]
}

struct Item: Codable {
    var sugar_g: Float
    var fiber_g: Float
    var serving_size_g: Float
    var sodium_mg: Float
    var name: String
    var potassium_mg: Float
    var fat_saturated_g: Float
    var fat_total_g: Float
    var calories: Float
    var cholesterol_mg: Float
    var protein_g: Float
    var carbohydrates_total_g: Float
}
