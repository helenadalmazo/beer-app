//
//  ViewController.swift
//  beer-app
//
//  Created by Helena Dalmazo on 13/08/20.
//  Copyright © 2020 Helena Dalmazo. All rights reserved.
//

import UIKit

class BeerViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var breweryTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var ratingView: BeerRatingView!
    @IBOutlet weak var colorSlider: UISlider!
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var beer: Beer?
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nameTextField.delegate = self
        imagePicker.delegate = self
        
        colorSlider.maximumValue = Float(BeerColor.shared.colors.count - 1)
        
        if let beer = beer {
            imageView.image = UIImage(data: beer.image!)
            nameTextField.text = beer.name
            breweryTextField.text = beer.brewery
            priceTextField.text = String(beer.price)
            ratingView.rating = Int(beer.rating)
            colorSlider.value = Float(BeerColor.shared.getIndex(of: beer.color as! UIColor))
            updateColor(color: beer.color as! UIColor)
            
            navigationItem.title = beer.name
        } else {
            beer = Beer(context: BeerRepository.shared.context)
        }
        
        updateSaveButtonState()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        navigationItem.title = textField.text
        updateSaveButtonState()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        
        let image = info[.originalImage] as? UIImage
        imageView.image = image
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            return
        }
        
        beer?.image = imageView.image!.pngData()!
        beer?.name = nameTextField.text ?? ""
        beer?.brewery = breweryTextField.text ?? ""
        beer?.price = Double(priceTextField.text ?? "0") ?? 0
        beer?.rating = Int16(ratingView.rating)
        beer?.color = colorView.backgroundColor
        
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
            self.imagePicker.sourceType = .camera
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        })
        
        let chooseImageFromCamera = UIAlertAction(title: "Gallery", style: .default, handler: { (_) in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = false
            self.present(self.imagePicker, animated: true, completion: nil)
        })
        
        let remove = UIAlertAction(title: "Remove", style: .destructive)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(takeImageFromCamera)
        alert.addAction(chooseImageFromCamera)
        alert.addAction(remove)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func changeColor(_ sender: UISlider) {
        let index = Int(sender.value)
        
        let color = BeerColor.shared.getUIColor(at: index)
        
        updateColor(color: color)
    }
    
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    private func updateColor(color: UIColor) {
        colorSlider.tintColor = color
        colorView.backgroundColor = color
    }
}

