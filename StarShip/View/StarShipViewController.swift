//
//  ViewController.swift
//  StarShip
//
//  Created by Jain, Vikas on 29/8/21.
//  Copyright © 2021 Jain, Vikas. All rights reserved.
//

import UIKit

class StarShipViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: StarShipViewModel?
    var starShipsModel: StarShips?
    var sortedArray: [StarShipModel]?
    var selectedIndex: Int = -1
    
    @IBOutlet weak var segementedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Events
    @IBAction func segmentedControl_Click(_ sender: Any) {
        switch self.segementedControl.selectedSegmentIndex {
        case 0:
            // Sorting by name
            sortedArray = self.starShipsModel?.allShips.sorted(by: { $0.name < $1.name })
        case 1:
            // Sorting by cost
            sortedArray = self.starShipsModel?.allShips.sorted(by: { $0.cost_in_credits < $1.cost_in_credits })
        case 2:
            // Only favorites
            sortedArray = self.viewModel?.favoriteStarShips
        default:
            break
        }

        self.tableView.reloadData()
    }
    
    /// Closure to get the callback event when favorite button is tapped in TableViewCell
    lazy var favoriteIconTapped:((_ model: StarShipModel) -> ()) = { [weak self] model in
        guard let self = self else {
            return
        }
        
        self.viewModel?.manageFavorite(starShip: model)
        self.tableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // Initialize properties
        self.viewModel = StarShipViewModel(delegate: self)
    }

    // MARK: - Page Lifecycle events
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Star Ships"
        self.setupTableView()
        self.loadContent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // To reload a particular row at selected index to update favorite state
        if selectedIndex >= 0 {
            let indexPath = IndexPath(row: selectedIndex, section: 0)
            tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    // MARK: - Private methods
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        
        self.registerTableViewCells()
    }
    
    private func registerTableViewCells() {
        let shipCell = UINib(nibName: "StarShipTableViewCell", bundle: nil)
        self.tableView.register(shipCell, forCellReuseIdentifier: "StarShipCell")
    }
    
    private func loadContent() {
        self.startActivityIndicator()
        
        //Get Starships data
        self.viewModel?.getStarShipsInfo()
    }
    
    // MARK: - Segue function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            guard let detailVC = segue.destination as? StarShipDetailViewController else {
                return
            }
            detailVC.starShipDetail = self.sortedArray?[selectedIndex]
            detailVC.viewModel = self.viewModel
        }
    }
}

extension StarShipViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sortedArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StarShipCell", for: indexPath) as? StarShipTableViewCell ?? StarShipTableViewCell(style: .default, reuseIdentifier: "StarShipCell")
        
        // Get the star ship model at indexPath
        guard let shipModel = self.sortedArray?[indexPath.row] else {
            return cell
        }
        
        // Check if model is favorited
        if let isFav = self.viewModel?.isFavorite(starShip: shipModel) {
            cell.isFavorite = isFav
        }
        
        cell.favoriteIconTapped = self.favoriteIconTapped
        cell.configureCell(modelInfo: shipModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: false)
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    private func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    private func startActivityIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
}

extension StarShipViewController: StarShipViewModelDelegate {
    // MARK: - StarShipViewModel delegate methods
    func handleError(_ error: StarShipError) {
        let alertController = UIAlertController(title: error.alertTitle, message: error.alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
        self.stopActivityIndicator()
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }
    
    func starShipInfoDelegate(_ value: StarShips) {
        self.stopActivityIndicator()
        self.starShipsModel = value
        self.sortedArray = self.starShipsModel?.allShips
        
        self.tableView.separatorStyle = .singleLine
        self.tableView.reloadData()
    }
}
