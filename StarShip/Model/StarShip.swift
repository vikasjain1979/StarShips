//
//  StarShipModel.swift
//  StarShip
//
//  Created by Jain, Vikas on 29/8/21.
//  Copyright © 2021 Jain, Vikas. All rights reserved.
//

import Foundation

struct StarShipModel: Codable{
    // MARK: - Properties
    var name: String
    var model: String
    var manufacturer: String
    var cost_in_credits: String
    var length: String
    var max_atmosphering_speed: String
    var crew: String
    var passengers: String
    var cargo_capacity: String
    var consumables: String
    var hyperdrive_rating: String
    var MGLT: String
    var starship_class: String
    var pilots: [String]
    var films: [String]
    var created: String
    var edited: String
    var url: String
    
    // MARK: - Custom variables
    
    // Return the object as dictionary to be used as a value array for Table View
    var asDictionary : [String:Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
            guard let label = label else { return nil }
            return (label, value)
        }).compactMap { $0 })
        return dict
    }
    
    // Return the object properties as a string array for Table View
    var propertyArray: [String] {   ["name","model","manufacturer","cost_in_credits","length","max_atmosphering_speed","crew","passengers","cargo_capacity","consumables","hyperdrive_rating","MGLT","starship_class","pilots","films","created","edited","url"]
    }
}
