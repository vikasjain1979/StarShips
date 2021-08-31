//
//  StarShipViewModel.swift
//  StarShip
//
//  Created by Jain, Vikas on 29/8/21.
//  Copyright © 2021 Jain, Vikas. All rights reserved.
//

import Foundation
import UIKit

// Delegate to handle the communication back to view controller with the star ship array.
protocol StarShipViewModelDelegate {
    // Callback when API data fetch is successful
    func starShipInfoDelegate(_ value: StarShips)
    
    // To handle any errors in API call
    func handleError(_ error: StarShipError)
}

public class StarShipViewModel {
    // MARK: - Properties
    var starShipsInfo: StarShips?
    
    // This will hold the favorite star ships info.
    var favoriteStarShips: [StarShipModel]
    let serviceRequestCoordinator: ServiceRequestPerforming
    
    var viewModelDelegate: StarShipViewModelDelegate?
    
    // MARK: - Initializer
    init(serviceCoordinator: ServiceRequestPerforming = ServiceRequestCoordinator(),
         delegate: StarShipViewModelDelegate) {
        self.serviceRequestCoordinator = serviceCoordinator
        self.viewModelDelegate = delegate
        self.favoriteStarShips = []
    }
    
    // MARK: - Public Methods
    func getStarShipsInfo() {
        //Call Service coordinator to fetch the API data
        self.serviceRequestCoordinator.fetchData(requestUrl: "https://swapi.dev/api/starships/") { result in
            switch result {
            case .success(let value):
                self.viewModelDelegate?.starShipInfoDelegate(value)
            case .failure(let error):
                self.viewModelDelegate?.handleError(error)
            }
        }
    }
    
    
    /// This will add or remove the starship as favorite.
    /// - Parameter starShip: StarShip model to be added to/removed from favorites
    func manageFavorite(starShip: StarShipModel) {
        if let index = self.favoriteStarShips.firstIndex(where: { $0.name == starShip.name }) {
            self.favoriteStarShips.remove(at: index)
        } else {
            self.favoriteStarShips.append(starShip)
        }
    }
    
    
    /// This will return a bool if a particular star ship is favorite or not
    /// - Parameter starShip: StarShip model to be checked
    func isFavorite(starShip: StarShipModel) -> Bool {
        if let index = self.favoriteStarShips.firstIndex(where: { $0.name == starShip.name }), index >= 0 {
            return true
        } else {
            return false
        }
    }
}
