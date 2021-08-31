//
//  StarShipsModel.swift
//  StarShip
//
//  Created by Jain, Vikas on 29/8/21.
//  Copyright © 2021 Jain, Vikas. All rights reserved.
//

import Foundation

struct StarShips: Decodable {
    // MARK: - Properties
    let count: Int
    var allShips: [StarShipModel]
    
    enum CodingKeys: String, CodingKey {
        case count
        case allShips = "results"
    }
}
