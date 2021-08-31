//
//  ServiceManager.swift
//  StarShip
//
//  Created by Jain, Vikas on 29/8/21.
//  Copyright © 2021 Jain, Vikas. All rights reserved.
//

import Foundation
import Alamofire

protocol ServiceRequestPerforming {
    // To fetch the star ship data from API based on the request URL
    func fetchData(requestUrl: String, onCompletion: @escaping(Result<StarShips, StarShipError>) -> Void)
}

class ServiceRequestCoordinator: ServiceRequestPerforming {
    public func fetchData(requestUrl: String, onCompletion: @escaping (Result<StarShips, StarShipError>) -> Void) {
        AF.request(requestUrl).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let starShipsData = try decoder.decode(StarShips.self, from: data!)
                    onCompletion(.success(starShipsData))
                }
                catch {
                    onCompletion(.failure(StarShipError.responseDecodingError))
                }
            case .failure(_):
                onCompletion(.failure(StarShipError.serviceUnavailable))
            }
        }
    }
}
