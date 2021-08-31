//
//  StarShipTableViewCell.swift
//  StarShip
//
//  Created by Jain, Vikas on 29/8/21.
//  Copyright © 2021 Jain, Vikas. All rights reserved.
//

import UIKit

/// Custom table view cell class to dispplay StarShip information in table view
class StarShipTableViewCell: UITableViewCell {
    // MARK: - Properties
    var shipModel: StarShipModel?
    var isFavorite: Bool = false
    
    // Closure to handle the event callback when favorite icon is tapped in table view cell
    var favoriteIconTapped: ((_ model: StarShipModel) -> ())?
    
    @IBOutlet weak var shipName: UILabel!
    @IBOutlet weak var shipCost: UILabel!
    @IBOutlet weak var shipRating: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    
    // MARK: - Events
    @IBAction func btnFavorite_Click(_ sender: Any) {
        self.favoriteIconTapped?(self.shipModel!)
    }
    
    // MARK: - Public Methods
    func configureCell(modelInfo: StarShipModel) {
        self.shipModel = modelInfo
        self.shipName.text = modelInfo.name
        self.shipCost.text = "Cost In Credits: \(modelInfo.cost_in_credits)"
        self.shipRating.text = "Hyperdrive Rating: \(modelInfo.hyperdrive_rating)"
        self.btnFavorite.accessibilityLabel = "Set \(modelInfo.name) as favorite"

        if self.isFavorite {
            btnFavorite.setImage(UIImage(named: "fav_icon_selected"), for: .normal)
        } else {
            btnFavorite.setImage(UIImage(named: "fav_icon_clear"), for: .normal)
        }
    }
}
