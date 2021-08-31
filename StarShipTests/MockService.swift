//
//  MockService.swift
//  StarShipTests
//
//  Created by Jain, Vikas on 31/8/21.
//  Copyright © 2021 Jain, Vikas. All rights reserved.
//

import Alamofire
import Foundation
import XCTest

@testable import StarShip

public final class MockService<T>: ServiceRequestPerforming {
    
    public var mockResponse: T?
    public var isForcedError: Bool = false
    
    public func fetchData(requestUrl: String, onCompletion: @escaping (Result<StarShips, StarShipError>) -> Void) {
        
        if self.isForcedError {
            onCompletion(.failure(.serviceUnavailable))
        } else {
            if let response = self.mockResponse as? StarShips {
                onCompletion(.success(response))
            } else {
                XCTFail("Response failure")
            }
        }
    }
}
