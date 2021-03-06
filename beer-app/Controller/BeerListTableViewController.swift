//
//  BeerListTableViewController.swift
//  beer-app
//
//  Created by Helena Dalmazo on 02/09/20.
//  Copyright © 2020 Helena Dalmazo. All rights reserved.
//

import UIKit

class BeerListTableViewController: UITableViewController, UISearchResultsUpdating {
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        searchController.searchResultsUpdater = self
        
        searchController.obscuresBackgroundDuringPresentation = false
        
        tableView.tableHeaderView = searchController.searchBar
        
        definesPresentationContext = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return BeerRepository.shared.beers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerReuseIdentifier", for: indexPath) as! BeerTableViewCell
        
        let beer = BeerRepository.shared.beers[indexPath.row]
        
        cell.nameLabel.text = beer.name
        cell.breweryLabel.text = beer.brewery
        if let image = beer.image {
            cell.imageImageView.image = UIImage(data: image)
        } else {
            cell.imageImageView.image = nil
        }
        cell.ratingImageView.image = UIImage(named: "Beer Rating Images/\(beer.rating)")!

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            BeerRepository.shared.delete(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        BeerRepository.shared.load(filter: searchController.searchBar.text)
        tableView.reloadData()
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let destination = segue.destination as? BeerViewController {
            
            if segue.identifier == "Edit" {
                let indexPath = tableView.indexPathForSelectedRow
                
                let beer = BeerRepository.shared.beers[indexPath!.row]
                
                destination.beer = beer
            }
        }
    }
    
    //MARK: Actions
    
    @IBAction func unwindToBeerList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? BeerViewController, let beer = sourceViewController.beer {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                BeerRepository.shared.update(beer, at: selectedIndexPath.row)
                
                tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            }
            else {
                let newIndexPath = IndexPath(row: BeerRepository.shared.beers.count, section: 0)
                
                BeerRepository.shared.save(beer)

                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
}
