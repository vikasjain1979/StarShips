//
//  MockResponse.swift
//  StarShipTests
//
//  Created by Jain, Vikas on 31/8/21.
//  Copyright © 2021 Jain, Vikas. All rights reserved.
//

import Foundation

@testable import StarShip

final class MockResponse {
    static func makeResponse() -> StarShips? {
        let bundle = Bundle(for: self)
        guard let apiUrl = bundle.url(forResource: "swapi_dev", withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: apiUrl)
            guard let starShipsInfo = try? JSONDecoder().decode(StarShips.self, from: data) else {
                return nil
            }
            
            return starShipsInfo
        } catch _ {
            return nil
        }        
    }
}
