//
//  StarShipDetailViewController.swift
//  StarShip
//
//  Created by Jain, Vikas on 30/8/21.
//  Copyright © 2021 Jain, Vikas. All rights reserved.
//

import UIKit

class StarShipDetailViewController: UIViewController {
    // MARK: - Properties
    var viewModel: StarShipViewModel?
    var starShipDetail: StarShipModel?
    var testName: String?

    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var btnFav: UIButton!
    
    // MARK: - Events
    @IBAction func favButton_Click(_ sender: Any) {
        guard let model = starShipDetail else {
            return
        }
        
        self.viewModel?.manageFavorite(starShip: model)
        self.markFavorites()
    }

    // MARK: - Page Lifecycle events
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = starShipDetail?.name
        self.setupTableView()
    }
    
    // MARK: - Private methods
    private func setupTableView() {
        self.detailTableView.dataSource = self
        self.detailTableView.delegate = self
        self.detailTableView.reloadData()
        self.markFavorites()
    }
    
    private func markFavorites() {
        if let model = self.starShipDetail,
            let isFav = self.viewModel?.isFavorite(starShip: model), isFav == true {
            self.btnFav.setImage(UIImage(named: "icon_fav_selected"), for: .normal)
        } else {
            self.btnFav.setImage(UIImage(named: "icon_fav_clear"), for: .normal)
        }
    }
}

extension StarShipDetailViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Tableview delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starShipDetail?.asDictionary.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.detailTableView.dequeueReusableCell(withIdentifier: "detailCell") ?? UITableViewCell(style: .default, reuseIdentifier: "detailCell")
        
        // Configure cell
        let valueDict = self.starShipDetail?.asDictionary
        if let property = self.starShipDetail?.propertyArray[indexPath.row] {
            cell.textLabel?.text = property.formatted()
            
            if let value = valueDict?[property] as? String {
                cell.detailTextLabel?.text = value
            } else if let value = valueDict?[property] as? [String] {
                cell.detailTextLabel?.text = value.first
            }
        }
        
        return cell
    }
}

extension String {
    /// Formats the string to replace any underscores with spaces and capitalizing 
    func formatted() -> String{
        return self.replacingOccurrences(of: "_", with: " ").capitalized
    }
}
