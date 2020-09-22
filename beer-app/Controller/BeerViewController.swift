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
    
    @IBAction func changeImage(_ sender: UIButton) {
        let alert = UIAlertController(title: "Would you like to take a image from...", message: nil, preferredStyle: .actionSheet)
        
        let takeImageFromCamera = UIAlertAction(title: "Camera", style: .default, handler: { (_) in
            print("User click Camera button")
        })
        
        let chooseImageFromCamera = UIAlertAction(title: "Gallery", style: .default, handler: { (_) in
            print("User click Gallery button")
        })
        
        let remove = UIAlertAction(title: "Remove", style: .destructive, handler: { (_) in
            print("User click Remove button")
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            print("User click Dismiss button")
        })
        
        alert.addAction(takeImageFromCamera)
        
        alert.addAction(chooseImageFromCamera)
        
        alert.addAction(remove)
        
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}

