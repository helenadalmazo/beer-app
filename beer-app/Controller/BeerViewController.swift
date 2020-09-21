//
//  ViewController.swift
//  beer-app
//
//  Created by Helena Dalmazo on 13/08/20.
//  Copyright © 2020 Helena Dalmazo. All rights reserved.
//

import UIKit

class BeerViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var breweryTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var ratingTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var beer: Beer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nameTextField.delegate = self
        
        if let beer = beer {
            nameTextField.text = beer.name
            breweryTextField.text = beer.brewery
            priceTextField.text = String(beer.price)
            ratingTextField.text = String(beer.rating)
            
            navigationItem.title = beer.name
        }
        
        updateSaveButtonState()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        navigationItem.title = textField.text
        updateSaveButtonState()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            return
        }
        
        let name = nameTextField.text ?? ""
        let brewery = breweryTextField.text ?? ""
        let price = Double(priceTextField.text ?? "0") ?? 0
        let rating = Int(ratingTextField.text ?? "0") ?? 0
        
        beer = Beer(name, brewery, price, rating)
    }
    
    // MARK: - Actions
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }
    }
    
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}

